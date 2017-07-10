module Asaas
  class Payments
    #CRIAR PAGAMENTO (BOLETOS)
    def self.Create(params = {})
      APIRequest.request("POST", "#{Asaas.base_uri}/payments",params)
    end

    #SHOW PAGAMENTOS DO ID CUSTUMER
    def self.Show(params = {})
      APIRequest.request("GET", "#{Asaas.base_uri}/payments",params)
    end

    #APAGAR COBRANÇA
    def self.Remove(id_pay)
      APIRequest.request("DELETE", "#{Asaas.base_uri}/payments/#{id_pay}")
    end

    #SHOW BOLETO UNICO -n esta mais em uso
    def self.ShowU(id_pay)
      APIRequest.request("GET", "#{Asaas.base_uri}/payments/#{id_pay}")
    end

    def self.ShowNoty
      APIRequest.request("GET", "#{Asaas.base_uri}/notifications")
    end

    def self.ShowNotyUser(id)
      APIRequest.request("GET", "#{Asaas.base_uri}/notifications/#{id}")
    end
  end
end
