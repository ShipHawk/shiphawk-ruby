module ShipHawk
  module Api
    # Carriers API
    #
    # @see https://shiphawk.com/api-docs
    #
    # The following API actions provide the CRUD interface to manage categories.
    #
    class Carriers < Resource

      def self.credentials(params={})
        response, api_key = ShipHawk::Client.request(:get, '/carriers/credentials', @api_key, params)
        ShipHawk::Helpers::Util::convert_to_ShipHawk_object(response, api_key) if response
      end

      def self.logo(params={})
        response, api_key = ShipHawk::Client.request(:get, '/carriers/logo', @api_key, params)
        ShipHawk::Helpers::Util::convert_to_ShipHawk_object(response, api_key) if response
      end
    end

  end
end