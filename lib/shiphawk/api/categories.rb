module ShipHawk
  module Api
    # Categories API
    #
    # @see https://shiphawk.com/api-docs
    #
    # The following API actions provide the CRUD interface to manage categories.
    #
    class Categories < Resource

      def self.search(params={})
        response, api_key = ShipHawk::Client.request(:get, '/categories/search', @api_key, params, )
        ShipHawk::Helpers::Util::convert_to_ShipHawk_object(response, api_key) if response
      end
    end

  end
end