class RelatorioMailer < ApplicationMailer

  def send_email(data, email_to, content)
    @content = content
    attachments["Relatório_#{Time.now}.xls"] = data
    mail to: email_to, subject: "[EvenTi 2017] - Relatório #{Time.now}"
  end


end
