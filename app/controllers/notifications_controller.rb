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
        payment_user.portion_paid = 1
        user.paid_on = Time.now
      when :avaliable
        payment_user.status_pagseguro = "Pago"
        payment_user.portion_paid = 1
        user.paid_on = Time.now
      when :in_dispute
      when :refunded
        payment_user.status_pagseguro = "Não processado"
        user.paid_on = nil
        # user.lot = nil
        payment_user.portion_paid = 0
      when :cancelled
        payment_user.status_pagseguro = "Não processado"
        user.paid_on = nil
        # user.lot = nil
        payment_user.portion_paid = 0
      when :chargeback_charged
        payment_user.status_pagseguro = "Não processado"
        user.paid_on = nil
        #  user.lot = nil
        payment_user.portion_paid = 0
      when :contested
        payment_user.status_pagseguro = "Não processado"
        payment_user.portion_paid = 0
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

  def confirm_payment_asaas
    unless params['event'].nil?
      billet = AsaasPayment.where(payment_asaas_id: params['payment']['id']).first
      if !billet.nil?
        case params['event']
        when "PAYMENT_CREATED"
          p 'PAGAMENTO CRIADO'
        when "PAYMENT_UPDATED"
          p 'PAGAMENTO ATUALIZADO'
        when "PAYMENT_RECEIVED"
          billet.status = params['payment']['status']
          billet.client_payment_date = Time.now
          billet.save

          billet.payment.portion_paid = AsaasPayment.where(status: 'RECEIVED', custumer_id: params['payment']['customer']).count
          billet.payment.user.paid_on = Time.now

          billet.payment.save
          billet.payment.user.save
        when "PAYMENT_OVERDUE" #Cobrança vencida
          billet.status = params['payment']['status']
          billet.save
        when :PAYMENT_DELETED
          p 'PAGAMENTO DELETADO'
        end

      else
        PaymentNotificationsMailer.asaas_error(params['payment']).deliver_now if params['event']=="PAYMENT_RECEIVED"
      end
    end
    render body: nil, status: 200
  end
end
