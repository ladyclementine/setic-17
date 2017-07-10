require "rails_helper"

RSpec.describe PaymentNotificationsMailer, type: :mailer do
  describe "asaas_error" do
    let(:mail) { PaymentNotificationsMailer.asaas_error }

    it "renders the headers" do
      expect(mail.subject).to eq("Asaas error")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "daily_report" do
    let(:mail) { PaymentNotificationsMailer.daily_report }

    it "renders the headers" do
      expect(mail.subject).to eq("Daily report")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
