class Crew::AdminsMethodsController < Crew::BaseController

  def move_user_to_lot
    lot = Lot.find(params[:lot_id])
    user = User.find(params[:user_id])

    if lot.is_full?
      redirect_to edit_crew_user_path(user), alert: "Não foi possíve mover o usuário para o lote #{lot.number}. CHEIO!"
      return false
    end

    if user.update_attribute(:lot_id, lot.id) && (user.update_attribute :active, true)
      redirect_to edit_crew_user_path(user), notice: "Usuário foi movido para o lote #{lot.number}"
    else
      redirect_to edit_crew_user_path(user), alert: "Não foi possíve mover o usuário para o lote #{lot.number}."
    end
  end

  def move_first_user_to_lot
    lot = Lot.find(params[:lot_id])
    if User.eligible.any?
      allocated_user = User.eligible.first
      allocated_user.update_attribute('lot_id', lot.id)
      UsersLotMailer.allocated(allocated_user).deliver_now
      redirect_to crew_users_waiting_list_path, notice: "Email enviado."
    end
  end


  def disqualify_user
    user = User.find(params[:id])
    if !user.nil?
      user.disqualify
      redirect_to edit_crew_user_path(user), notice: "Usuário desqualificado."
    else
      redirect_to edit_crew_user_path(user), alert: "Não foi possível desqualificar."
    end
  end

  def billet_portion_paid
    asaaspayment = AsaasPayment.find(params[:id])
    unless asaaspayment.status == 'RECEIVED'
      asaaspayment.update_attribute :status, 'RECEIVED'
      asaaspayment.update_attribute :client_payment_date,  Time.now
      unless asaaspayment.payment.paid?
        asaaspayment.payment.update_attribute :portion_paid, params[:portion_paid]
      end
    end
    redirect_to edit_crew_user_path(asaaspayment.payment.user), notice: "O status do pagamento de #{asaaspayment.payment.user.email} foi alterado."
  end

  def change_payment_status
    payment = Payment.find(params[:id])
    status = params[:status]
    case status
    when "paid"
      payment.update_attribute :portion_paid, payment.portions
      payment.update_attribute :status_pagseguro, 'Paid' if payment.method=='PagSeguro'
      payment.asaas_payments.update_all status: 'RECEIVED' if payment.method=='Boleto'
      payment.asaas_payments.update_all client_payment_date: Time.now if payment.method=='Boleto'
      payment.save
      redirect_to edit_crew_user_path(payment.user), notice: "O status do pagamento de #{payment.user.email} foi alterado."
    when "NON"
      payment.update_attribute :portion_paid, 0
      payment.update_attribute :status_pagseguro, nil if payment.method=='PagSeguro'
      payment.asaas_payments.update_all status: 'PENDING' if payment.method=='Boleto'
      payment.asaas_payments.update_all client_payment_date: nil if payment.method=='Boleto'
      payment.save
      redirect_to edit_crew_user_path(payment.user), notice: "O status do pagamento de #{payment.user.email} foi alterado."
    end
  end

  def remove_payment_method
    payment = Payment.find(params[:id])
    user = payment.user
    if payment.portion_paid == 0
      payment.asaas_payments.destroy_all
      payment.destroy
    else
      redirect_to edit_crew_user_path(user), alert: "Não foi possível apagar o método de pagamento."
      return false
    end

    if payment.save
      redirect_to edit_crew_user_path(user), notice: "Método do pagamento de #{payment.user.email} foi apagado."
    else
      redirect_to edit_crew_user_path(user), alert: "Não foi possível apagar o método de pagamento"
    end
  end

  def login
    user = User.find( params[:user_id] )
   # redirect_to crew_users_path, notice: user
    sign_in_and_redirect user
  end


end
