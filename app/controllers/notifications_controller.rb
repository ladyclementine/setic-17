class NotificationsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:confirm_payment, :confirm_payment_asaas]

  def confirm_payment
    transaction = PagSeguro::Transaction.find_by_notification_code(params[:notificationCode])

    if transaction.errors.empty?
      Rails.logger.info "\n\n\n TRANSAÇÃO ENCONTRADA"
      #Rails.logger.info "\n\n  Enviada por #{transaction.items}"

      Rails.logger.info "\n\n  Status: #{transaction.status.status}"
      #user = User.where(email: 'pixelzip0@gmail.com').first #EM TESTE
      user = User.where(id: transaction.reference.split('user')[1]).first
      payment_user = user.payment
      case transaction.status.status
      when :initiated
        payment_user.status_pagseguro = "Em processamento"
      when :waiting_payment
        payment_user.status_pagseguro = "Em processamento"
      when :in_analysis
        payment_user.status_pagseguro = "Em processamento"
      when :paid
        payment_user.status_pagseguro = "Pago"
        payment_user.status = "Confirmado"
        #user.paid_on = Time.now
      when :avaliable
        payment_user.status_pagseguro = "Pago"
        payment_user.status = "Confirmado"
        #user.paid_on = Time.now
      when :in_dispute
      when :refunded
        payment_user.status_pagseguro = "Não processado"
        #user.paid_on = nil
        # user.lot = nil
        payment_user.status = "Pendente"
      when :cancelled
        payment_user.status_pagseguro = "Não processado"
        #user.paid_on = nil
        # user.lot = nil
        payment_user.status = "Pendente"
      when :chargeback_charged
        payment_user.status_pagseguro = "Não processado"
        #user.paid_on = nil
        #  user.lot = nil
        payment_user.status = "Pendente"
      when :contested
        payment_user.status_pagseguro = "Não processado"
        payment_user.status = "Pendente"
      end
      user.save
      payment_user.save
    else
      Rails.logger.info "\n\n\n   Erros ao receber notificação:"
      transaction.errors.to_a.each do |error|
        Rails.logger.info "  - #{error}"
      end
    end

    render body: nil, status: 200
  end

end
