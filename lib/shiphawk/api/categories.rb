module ShipHawk
  module Api
    # Categories API
    #
    # @see https://shiphawk.com/api-docs
    #
    # The following API actions provide the CRUD interface to manage categories.
    #
    class Categories < Resource

      def self.find_all
        response, api_key = ShipHawk::Client.request(:get, '/categories', @api_key, {}, {}, true)
        ShipHawk::Helpers::Util::convert_to_ShipHawk_object(response, api_key) if response
      end

      def self.build(params={})
        response, api_key = ShipHawk::Client.request(:post, '/categories', @api_key, params, {}, true)
        ShipHawk::Helpers::Util::convert_to_ShipHawk_object(response, api_key) if response
      end

    end

  end
end