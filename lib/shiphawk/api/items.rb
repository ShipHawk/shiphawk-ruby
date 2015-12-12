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
        response, api_key = ShipHawk::Client.request(:get, '/items/search', @api_key, params)
        ShipHawk::Helpers::Util::convert_to_ShipHawk_object(response, api_key) if response
      end

      def self.item_object(l=nil,w=nil,h=nil,lbs=nil,id=nil,packed=false,value=nil)
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