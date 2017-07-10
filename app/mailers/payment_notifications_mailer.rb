class PaymentNotificationsMailer < ApplicationMailer
  # PaymentNotificationsMailer.asaas_error().deliver_now
  def asaas_error(json)
    @json = json
    mail to: 'pixelzip0@gmail.com', subject: "ASAAS - EFEJ 2017 - Pagamento não encontrado"
  end


  def daily_report
    @greeting = "Hi"
    mail to: "to@example.org"
  end
end
