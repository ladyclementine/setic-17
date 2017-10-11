class CheckoutController < BaseController
  before_action :get_user
  before_action :verify_register_conclusion
  before_action :redirect_if_try_pay_has_select, only: [:create, :exit_event] # PENDENTE
  before_action :redirect_if_events_blank
  before_action :check_permanent_event, only: [:exit_event] 

  def check_permanent_event
    event = Event.find(params[:id])
    if event.event_type.name == "Palestra" || event.event_type.name == "Mesa-Redonda"
      redirect_to payment_path, notice: "Não é possível remover programação obrigatória."
      return true
    end
  end


  require "#{Rails.root}/config/initializers/packages.rb"

  def close_payments
    flash[:notice] = "Por enquanto, não estamos processando novos pagamentos."
    redirect_to authenticated_user_root_path
  end

  def new
    @user_cart = @user.events.order(:is_shirt, :event_type_id)
    @payment = Payment.new
  end

  def create
    @cart_events = @user.events
    @total_price = @user.total_cart_discount

    if @cart_events.any?
      @user.payment ||= Payment.new do |payment|
        payment.method = payment_params[:method]
        payment.price = @total_price
      end
      @payment = @user.payment
      PaymentMailer.new_payment(@user, @payment).deliver_now
      PaymentMailer.info(@user, @payment, @config).deliver_now
      #@user.payment.pay_pagseguro if payment_params[:method] == "PagSeguro"
      redirect_to payment_path, notice: "Compra finalizada com sucesso! Verifique as informações para efetuar o pagamento."
    else
      redirect_to payment_path, notice: "Erro. Selecione uma programação!"
    end


    #@user.payment.pay_asaas
  end


  def change_payment
    if PaymentMailer.require_change(@user).deliver_now
      redirect_to :payment, notice: 'Sua solicitação foi enviada, aguarde contato!'
    end
  end

  def exit_event
    event = Event.find(params[:id])
    event.remove current_user
    if event.contains? current_user
      redirect_to payment_path, notice: "Não foi possível sair da programação."
    else
      redirect_to payment_path, notice: "Você saiu da programação."
    end
  end


  private
  def redirect_if_try_pay_has_select
    payment = @user.payment
    if !payment.nil?
      redirect_to authenticated_user_root_path, notice: "Você já selecionou pagamento."
    end
  end

  def redirect_if_events_blank
    redirect_to events_path, notice: "Selecione sua programação!" unless @user.events.any?
  end

  def payment_params
    params.require(:payment).permit(:method)
  end
end
