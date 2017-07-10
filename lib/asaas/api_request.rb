module Asaas
  require "rest_client"
  require "base64"
  require "json"

  class APIRequest
    def self.request(method, url, data = {})
      Asaas::Utils.auth_from_env if Asaas.api_key.nil?
      return RequestWithErrors.new  "Chave de API não configurada. Utilize Asaas.api_key = ... para configurar." if Asaas.api_key.nil?
      #  flash[:error] = "Chave de API não configurada. Utilize Asaas.api_key = ... para configurar."  if Asaas.api_key.nil?
      return handle_response self.send_request method, url, data
    end


    private

    def self.send_request(method, url, data)
      RestClient::Request.execute build_request(method, url, data)
    rescue RestClient::ResourceNotFound
      raise ObjectNotFound
    rescue RestClient::UnprocessableEntity => ex
      raise RequestWithErrors.new JSON.parse(ex.response)['errors']
    rescue RestClient::BadRequest => ex
      raise RequestWithErrors.new JSON.parse(ex.response)
    end

    def self.build_request(method, url, data)
      {
        headers:  data['form'].nil? ? default_headers : form_headers,
        method: method,
        payload: data.to_json,
        url: url,
        timeout: 30
      }
    end

    def self.handle_response(response)
      response_json = JSON.parse(response.body)
      raise ObjectNotFound if response_json.is_a?(Hash) && response_json['errors'] == "Not Found"
      raise RequestWithErrors, response_json['errors'] if response_json.is_a?(Hash) && response_json['errors'] && response_json['errors'].length > 0
      response_json
    rescue JSON::ParserError
      raise RequestFailed
    end

    def self.default_headers
      {
        params: {access_token: Asaas.api_key},
        accept_charset: 'utf-8',
        accept_language: 'pt-br;q=0.9,pt-BR',
        content_type: 'application/json; charset=utf-8'
      }
    end

    def self.form_headers
      {
        params: {access_token: Asaas.api_key},
        accept_charset: 'utf-8',
        accept_language: 'pt-br;q=0.9,pt-BR',
        content_type: 'application/x-www-form-urlencoded; charset=utf-8' 
      }
    end
  end
end
