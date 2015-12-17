module ShipHawk

  # Items API
  #
  # @see https://shiphawk.com/api-docs
  #
  # The following API actions provide the CRUD interface to managing items.
  #

  class Items < Resource

    def self.search(params={})
      response, api_key = ShipHawk::ApiClient.request(:get, '/items/search', @api_key, params)
      ShipHawk::Util::convert_to_ShipHawk_object(response, api_key) if response
    end

    def self.item_object(items)
     JSON.parse(items.to_json)
    end

  end

end