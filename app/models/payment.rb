class Payment < ApplicationRecord
  belongs_to :user
  has_many :asaas_payments,  foreign_key: 'custumer_id', primary_key: 'user_asaas_id'
  validates :portions, numericality: { less_than_or_equal_to: 3, greater_than: 0 }
  acts_as_paranoid


  def paid?
    self.portion_paid == self.portions
  end

  def partially_paid?
    self.portion_paid > 0 ? true : false
  end

  #NOVO METODO - MODULO NOHOST
  def set_price
    if self.user.lot.nohost_active
      self.host ? self.user.paid_lot_value : self.user.paid_lot_nohost_value
    else
      self.user.paid_lot_value
    end
  end

  ########### PAGSEGURO ###################
  def set_name_description
    self.user.is_fed? ? '- Federado ' : '- Não Federado '
  end

  def set_name_host
    if self.user.lot.nohost_active
      self.host ? '- Com Hospedagem' : '- Sem Hospedagem'
    end
  end

  def price_pagseguro
    percert_taxa = 0.0399
    fixed_taxa = 0.4
    total = (set_price + fixed_taxa) / (1 - percert_taxa)
    return '%.2f' % total
  end

  def pay_pagseguro
    update(price: set_price) unless set_price.nil?
    payment = PagSeguro::PaymentRequest.new

    payment.reference = "REFl#{self.user.lot_id}user#{self.user.id}"

    if Rails.env.development? || Rails.env.test?
      payment.notification_url = 'http://localhost:3000/confirm_payment'
      payment.redirect_url = 'http://localhost:3000/'
    else
      payment.notification_url = 'https://rjfej17.herokuapp.com/confirm_payment'
      payment.redirect_url = 'http://www.efej.com.br'
    end

    payment.items << {
      id: self.user.id,
      description: "#{self.user.lot.name} #{set_name_description} #{set_name_host}" ,
      amount: price_pagseguro
    }

    payment.sender = {
      email: self.user.email,
      cpf: self.user.cpf.numero.only_numbers,
      phone: {
        area_code: self.user.phone.only_numbers[0..1],
        number: self.user.phone.only_numbers[2..10]
      }
    }

    response = payment.register

    if response.errors.any?
      raise response.errors.join("\n")
    else
      update(url_pagseguro: response.url)
    end
  end

  ########### BOLETO ASAAS ###################
  def pay_asaas
    # 1° CRIAR CONTA NO ASAAS CASO NÃO EXISTA (a verifiação será feita só no sistema)
    self.user_asaas_id.nil? ? create_user_asaas : self.user_asaas_id
    # 2° GERAR FATURAS
    create_billets #no asaas
    generate_links_billets #no sistema
  end

  #no asaas
  #em caso de n gerar os boletos :  @user.payment.create_billets e  @user.payment.generate_links_billets
  # def create_billets
  #   return false if self.user_asaas_id.nil?
  #   return false if self.asaas_payments.any?
  #   response = Asaas::Payments.Create(
  #     "customer"=> self.user_asaas_id,
  #     "value"=> set_price + 2.00,
  #     "billingType"=> "BOLETO",
  #     "dueDate"=> Asaas::Utils.data_vencimento,
  #     "installmentCount"=>Asaas::Utils.check_portions(self.portions),
  #     "installmentValue"=>set_price/Asaas::Utils.check_portions(self.portions) + 2.00
  #   )
  #   update(price: set_price) unless set_price.nil?
  # end


  def create_billets
    return false if self.user_asaas_id.nil?
    return false if self.asaas_payments.any?
    config = YAML.load_file("#{Rails.root.to_s}/config/asaas.yml")
    vencimentos = config['vencimentos']
    qnt_parcelas = Asaas::Utils.check_portions(self.portions)

    qnt_parcelas.times do |i|
      response = Asaas::Payments.Create(
        "customer"=> self.user_asaas_id,
        "value"=> set_price/qnt_parcelas + 2.00,
        "billingType"=> "BOLETO",
        "dueDate"=>  Date.parse(vencimentos["mes#{i+1}"]).strftime("%Y-%m-%d"),
        "description" => "Parcela #{i+1} de #{qnt_parcelas}."
      )
    end

    update(price: set_price) unless set_price.nil?
  end


  def generate_links_billets
    return false if self.user_asaas_id.nil?
    return false if self.asaas_payments.any?
    row_list_billet = Asaas::Payments.Show("customer"=>self.user_asaas_id)

    billet_url = row_list_billet['data'].reverse!
    billet_url.map do |payment_billet|
      asaas_db = AsaasPayment.new do |payment|
        payment.payment_asaas_id = payment_billet['id']
        payment.installment = payment_billet['installment']
        payment.custumer_id = payment_billet['customer']
        payment.boleto_url = payment_billet['bankSlipUrl']
        payment.fatura_url = payment_billet['invoiceUrl']
        payment.description = payment_billet['description']
      end
      asaas_db.save
    end

  end

  private

  def create_user_asaas
    custumer_id = Asaas::Clients.Create(
      "name"=> self.user.name,
      "email"=> self.user.email,
      "mobilePhone"=> self.user.phone.only_numbers,
      "cpfCnpj"=> self.user.cpf.numero.only_numbers,
      "company"=> self.user.junior_enterprise
    )
    update(user_asaas_id: custumer_id) unless custumer_id.nil?
    return custumer_id
  end
end
