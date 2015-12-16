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


[{"id"=>"1265", "xid"=>"1123123", "length"=>10.0, "width"=>10.0, "height"=>10.0, "weight"=>6.024096385542169, "value"=>100.0, "quantity"=>1, "packed"=>false, "require_crating"=>false, "description"=>"Product 1", "package_qty"=>1}]

[{:id=>1265, :xid=>1, :length=>10.0, :width=>10.0, :height=>10.0, :weight=>6.024096385542169, :value=>100.0, :quantity=>1, :packed=>false, :require_crating=>false, :description=>"Product 1", :package_type=>"unpacked", :package_qty=>1}]
rates = ShipHawk::Rates.build(
    "to_zip" => to_zip,
    "from_zip" => from_zip,
    "items" => items
)