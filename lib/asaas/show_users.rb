module Asaas
  class Clients
    def self.Create(params = {})
      row_id = APIRequest.request("POST", "#{Asaas.base_uri}/customers",params)
      row_id['id']
    end
  end
end
