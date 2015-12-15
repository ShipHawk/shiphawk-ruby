module ShipHawk
  module Api
    # Products API
    #
    # @see https://shiphawk.com/api-docs
    #
    # The following API actions provide the CRUD interface to manage products.
    #
    class Products < Resource

      def self.search(params={})
        response, api_key = ShipHawk::Client.request(:get, '/products/search', @api_key, params)
        JSON.parse(response.to_json) if response
      end
    end

  end
end