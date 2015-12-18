module ShipHawk

  # Rates API
  #
  # @see https://shiphawk.com/api-docs
  #
  # The following API actions provide the CRUD interface to managing rates.
  #
  class Rates < Resource

    # create a new set of rates
    # @params [ items ], Object, required
    #         [ to_zip ], string, required
    #         [ from_zip ], string, require

    def self.build(params={})

      begin
        api_key = ShipHawk.configure.api_key
        api_base = ShipHawk.configure.base_url
        params = {}.merge(params)
        response = RestClient.post("#{api_base}/rates?api_key=#{api_key}", params.to_json, :content_type => :json)
        puts "Response status: #{response.code}"
        JSON.parse(response) if response
      rescue => e
        JSON.parse(e.response) if e
      end
    end

    # create a new set of standard rates

    def self.create_standard_rates(params={})
      response, api_key = ShipHawk::ApiClient.request(:post, '/rates/standard', @api_key, params)
      ShipHawk::Util::convert_to_ShipHawk_object(response, api_key) if response
    end

    #get rates for vehicle transportation

    def self.get_vehicle_rates(params={})
      response, api_key = ShipHawk::ApiClient.request(:get, '/rates/vehicle', @api_key, params)
      ShipHawk::Util::convert_to_ShipHawk_object(response, api_key) if response
    end

  end

end