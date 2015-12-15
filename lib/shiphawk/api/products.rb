module ShipHawk
  module Api
    # Products API
    #
    # @see https://shiphawk.com/api-docs
    #
    # The following API actions provide the CRUD interface to manage products.
    #
    class Products < Resource

      def self.find_by(product_sku)
        response, api_key = ShipHawk::Client.request(:get, "/products/#{product_sku}", @api_key, {}, {}, true)
        ShipHawk::Helpers::Util::convert_to_ShipHawk_object(response, api_key) if response
      end
    end
  end
end