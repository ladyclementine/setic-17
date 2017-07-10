# Preview all emails at http://localhost:3000/rails/mailers/payment_notifications
class PaymentNotificationsPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/payment_notifications/asaas_error
  def asaas_error
    PaymentNotificationsMailer.asaas_error
  end

  # Preview this email at http://localhost:3000/rails/mailers/payment_notifications/daily_report
  def daily_report
    PaymentNotificationsMailer.daily_report
  end

end
