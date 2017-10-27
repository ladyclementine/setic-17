# Preview all emails at http://localhost:3000/rails/mailers/notices_mailer
class NoticesMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notices_mailer/send_notification
  def send_notification
    NoticesMailerMailer.send_notification
  end

end
