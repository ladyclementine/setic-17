class CheckoutController < BaseController
  before_action :get_user
  before_action :verify_register_conclusion
  before_action :verify_user_lot
  before_action :redirect_if_user_has_paid, except: [:try_again] # PENDENTE

  #before_action :close_payments
  def close_payments
    flash[:notice] = "Por enquanto, não estamos processando novos pagamentos."
    redirect_to authenticated_user_root_path
  end

  def new
  end

  def billet
    @user.payment ||= Payment.new do |payment|
      payment.method = "Boleto"
      payment.portions = Asaas::Utils.check_portions(params[:installmentCount].to_i)
    end
    begin
      @user.payment.pay_asaas

      if @user.payment.portions > 1
        message = "Os links dos boletos referentes as #{@user.payment.portions} parcelas da inscrição estão disponíveis na tela principal do sistema."
      else
        message = "O link do boleto referente a inscrição está disponível na tela principal do sistema."
      end
    rescue => ex
      message = "Houve um erro na hora de processar seus boletos."
    end
    redirect_to authenticated_user_root_path, notice: message
  end

  def try_again
    payment = @user.payment
    if payment.portion_paid == 0 && !payment.asaas_payments.any?
      #payment.asaas_payments.destroy_all
      #payment.destroy
      begin
        # do some dangerous stuff, like running test scripts
        @user.payment.pay_asaas
        if @user.payment.portions > 1
          message = "Os links dos boletos referentes as #{@user.payment.portions} parcelas da inscrição estão disponíveis na tela principal do sistema."
        else
          message = "O link do boleto referente a inscrição está disponível na tela principal do sistema."
        end
        redirect_to authenticated_user_root_path, notice: message
      rescue => ex
        # do nothing here, except for logging, maybe
        redirect_to authenticated_user_root_path, notice: "Não foi possível gerar seus boletos. Tente novamente mais tarde."
      end
    else
      redirect_to authenticated_user_root_path, alert: "Não foi possível gerar seu pagamento."
      return false
    end
  end


  def pagseguro
    @user.payment ||= Payment.new do |payment|
      payment.method = "PagSeguro"
      payment.portions = 1
    end

    @user.payment.pay_pagseguro

    if @user.payment.method == "PagSeguro"
      message = "O link do pagamento referente a inscrição está disponível na tela principal do sistema."
      flash[:notice] = message
      redirect_to controller: 'user_dashboard', action: 'index', view: 'true'
    else
      redirect_to authenticated_user_root_path, notice: "Você não tem acesso."
    end

  end

  private
  def redirect_if_user_has_paid
    payment = @user.payment
    if !payment.nil? && payment.paid?
      # flash[:notice] = "Sua inscrição já foi paga!"
      redirect_to authenticated_user_root_path, notice: "Sua inscrição já foi paga!"
    else
      get_payment
    end
  end

  def get_payment
    if @user.payment.nil? # do nothing
    elsif controller_name != "billet" && @user.payment.method == "PagSeguro"
      flash[:alert] = "Link de Pagamento Atualizado"
      @user.payment.pay_pagseguro
      # redirect_to authenticated_user_root_path, something: 'else'
      redirect_to controller: 'user_dashboard', action: 'index', view: 'true'
    elsif controller_name != "billets" && @user.payment.method == "Boleto"
      if !@user.payment.asaas_payments.any?
        flash[:alert] = "Por favor, entre em contato conosco."
      else
        flash[:alert] = "Seu método de pagamento ja foi escolhido."
      end
      redirect_to authenticated_user_root_path
    end
  end


end
