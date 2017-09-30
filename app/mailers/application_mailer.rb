class ApplicationMailer < ActionMailer::Base
  include SendGrid if Rails.env.production?
  default :from => %{"SEMANAS 2017" <#{Rails.application.secrets.sender_email}>}
  layout 'mailer'
end

