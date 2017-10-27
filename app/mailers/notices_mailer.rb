class NoticesMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notices_mailer.send_notification.subject
  #
  def send_notification(user, comment)
      @user = user
      @comment = comment
      mail(to: @user.email, from: Rails.application.secrets.sender_email, subject: "A SETIC cadastrou uma nova notícia")
    end
end
