module Shiphawk
  class Client

    PRODUCTION_API_HOST = 'https://shiphawk.com'

    include Shiphawk::Helpers::Request
    include Shiphawk::Helpers::Response
    include Shiphawk::Api::QueryHelpers
    include Shiphawk::Api::ApiKeys
    include Shiphawk::Api::Company
    include Shiphawk::Api::Items
    include Shiphawk::Api::Rates
    include Shiphawk::Api::Shipments
    include Shiphawk::Api::ZipCodes

    attr_reader :api_token, :options

    def initialize(options={api_token: Shiphawk.api_key})
      @options = options
      @api_token = options.delete(:api_token) { |key| Shiphawk.api_key }
      @host_url = options.delete(:host_url) { |key| PRODUCTION_API_HOST }
      @adapter = options.delete(:adapter) { |key| Faraday.default_adapter }
    end

  end
end