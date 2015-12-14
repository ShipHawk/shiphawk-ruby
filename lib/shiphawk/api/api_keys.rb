module ShipHawk
  module Api

    # ApiKeys API
    #
    # @see https://shiphawk.com/api-docs
    #
    # The following API actions provide the CRUD interface to managing api keys.
    #
    class ApiKeys < Resource

      # Regenerate SandBox API key for your account
      def self.regenerate_sandbox
        response, api_key = ShipHawk::Client.request(:put, '/api_keys/sandbox', @api_key)
        ShipHawk::Helpers::Util::convert_to_ShipHawk_object(response, api_key) if response
      end

      # Regenerate Production API key for your account
      def self.regenerate_production
        response, api_key = ShipHawk::Client.request(:put, '/api_keys/production', @api_key)
        ShipHawk::Helpers::Util::convert_to_ShipHawk_object(response, api_key) if response
      end

    end

  end
end