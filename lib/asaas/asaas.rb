module Asaas
  #BY PATRICK MAGALHAES
  require_relative "utils"
  require_relative "api_request"
  require_relative "show_users"
  require_relative "payments"

  class RequestWithErrors < StandardError
    attr_accessor :errors

    def initialize(errors)
      @errors = errors
    end
  end

  class << self
    attr_accessor :api_key
  end

  @api_version = 'v3'
  @endpoint = 'https://www.asaas.com/api'

  def self.base_uri
    "#{@endpoint}/#{@api_version}"
  end
end
