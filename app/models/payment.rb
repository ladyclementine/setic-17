class Payment < ApplicationRecord
  belongs_to :user
  acts_as_paranoid

  validate :validate_payment_method
  before_validation :waiting, on: :create

  enum status: { 'Confirmado':true, 'Pendente':false }

  def waiting
    self.status = self.accepted_payment_status[0]
  end

  def paid?
    self.status == self.accepted_payment_status[1]
  end

  #validate :validate_payment_method, :validate_payment_status

  def accepted_payment_methods
    ['PagSeguro']
  end

  def accepted_payment_status
    ['Pendente', 'Confirmado']
  end

  def validate_payment_method
    errors.add("Método de pagamento","é inválido.") unless payment_method_is_valid?
  end

  def validate_payment_status
    errors.add("Status do pagamento","é inválido.") unless payment_status_is_valid?
  end

  def payment_method_is_valid?
    self.accepted_payment_methods.include? self.method
  end

  def payment_status_is_valid?
    self.accepted_payment_status.include? self.status
  end



  def price_pagseguro
    percert_taxa = 0.0399
    fixed_taxa = 0.4
    total = (self.price + fixed_taxa) / (1 - percert_taxa)
    return '%.2f' % total
  end

  def pay_pagseguro
    p 11111111111
    payment = PagSeguro::PaymentRequest.new

    payment.reference = "REFl#user#{self.user.id}"

    if Rails.env.development? || Rails.env.test?
      payment.notification_url = 'http://localhost:3000/confirm_payment'
      payment.redirect_url = 'http://localhost:3000/'
    else
      payment.notification_url = 'https://seq17.herokuapp.com/confirm_payment'
      payment.redirect_url = 'https://seq17.herokuapp.com'
    end

    payment.items << {
      id: self.user.id,
      description: "PAGAMENTO DA SEQ" ,
      amount: price_pagseguro
    }

    payment.sender = {
      email: self.user.email,
      cpf: self.user.cpf.numero.only_numbers,
    }

    response = payment.register

    if response.errors.any?
      raise response.errors.join("\n")
    else
       response.url
    end
  end

end
