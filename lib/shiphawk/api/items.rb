module ShipHawk
  module Api

    # Items API
    #
    # @see https://shiphawk.com/api-docs
    #
    # The following API actions provide the CRUD interface to managing items.
    #
    class Items < Resource

      def self.search(params={})
        response, api_key = ShipHawk.request(:get, '/items/search', api_key, params)
        ShipHawk::Helpers::Util::convert_to_ShipHawk_object(response, api_key) if response
      end

      def self.create_item_object(l,w,h,lbs,id,packed,value)
        {
            "length" => l,
            "width" => w,
            "height" => h,
            "weight" => lbs,
            "packed" => packed,
            "id" => id.to_s,
            "value" => value
        }
      end

    end

  end
end