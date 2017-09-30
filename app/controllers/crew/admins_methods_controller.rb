class Crew::AdminsMethodsController < Crew::BaseController


  def disqualify_user
    user = User.find(params[:id])
    if !user.nil?
      user.disqualify
      redirect_to edit_crew_user_path(user), notice: "Usuário desqualificado."
    else
      redirect_to edit_crew_user_path(user), alert: "Não foi possível desqualificar."
    end
  end


  def change_payment_status
    payment = Payment.find(params[:id])
    status = params[:status]
    case status
    when "paid"
      payment.update_attribute :status_pagseguro, 'Paid' if payment.method=='PagSeguro'
      payment.update_attribute :status, "Confirmado"
      redirect_to edit_crew_user_path(payment.user), notice: "O status do pagamento de #{payment.user.email} foi alterado."
    when "NON"
      payment.update_attribute :status_pagseguro, nil if payment.method=='PagSeguro'
      payment.update_attribute :status, "Pendente"
      redirect_to edit_crew_user_path(payment.user), notice: "O status do pagamento de #{payment.user.email} foi alterado."
    end
  end

  def remove_payment_method
    payment = Payment.find(params[:id])
    user = payment.user
    unless payment.paid? 
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
