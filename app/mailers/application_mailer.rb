class ApplicationMailer < ActionMailer::Base
  include SendGrid if Rails.env.production?
  default :from => %{"EFEJ  2017" <jurfin@riojunior.com.br>}
  layout 'mailer'
end

