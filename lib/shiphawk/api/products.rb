module ShipHawk
  # Products API
  #
  # @see https://shiphawk.com/api-docs
  #
  # The following API actions provide the CRUD interface to manage products.
  #
  class Products < Resource

    def self.find_by(product_sku)
      response, api_key = ShipHawk::ApiClient.request(:get, "/products/#{product_sku}", @api_key, {}, {}, true)
      ShipHawk::Util::convert_to_ShipHawk_object(response, api_key) if response
    end

    def self.build(params={})
      response, api_key = ShipHawk::ApiClient.request(:post, '/products', @api_key, params, {}, true)
      ShipHawk::Util::convert_to_ShipHawk_object(response, api_key) if response
    end
  end
end