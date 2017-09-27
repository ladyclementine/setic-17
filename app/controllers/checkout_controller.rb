class CheckoutController < BaseController
  before_action :get_user
  before_action :verify_register_conclusion
  before_action :redirect_if_try_pay_has_select, only: [:create, :exit_event] # PENDENTE

  require "#{Rails.root}/config/initializers/packages.rb"

  def close_payments
    flash[:notice] = "Por enquanto, não estamos processando novos pagamentos."
    redirect_to authenticated_user_root_path
  end

  def new
    @user_cart = @user.all_itens.order(:is_shirt, :event_type_id)
    @payment = Payment.new
  end

  def create
    @cart_events = @user.events
    @total_price = @user.total_cart_discount

    @user.payment ||= Payment.new do |payment|
       payment.method = payment_params[:method]
       payment.price = @total_price 
    end
  
    redirect_to payment_path, notice: "Compra finalizada com sucesso! Verifique as informações para efetuar o pagamento."
    #@user.payment.pay_asaas
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

  def payment_params
    params.require(:payment).permit(:method)
  end
end
