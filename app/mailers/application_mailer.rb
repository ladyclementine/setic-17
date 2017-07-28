class ApplicationMailer < ActionMailer::Base
  include SendGrid if Rails.env.production?
  default :from => %{"EFEJ  017" <gtiengenhariajr@gmail.com>}
  layout 'mailer'
end

