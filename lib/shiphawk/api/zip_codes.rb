module ShipHawk
    # Zip Codes API
    #
    # @see https://shiphawk.com/api-docs
    #
    # The following API actions provide the CRUD interface to managing zip codes.
    #
    #

  class ZipCodes < Resource

    # Search All ZipCodes
    # @param q, query zip.
    # @return [Object<ZipCods>]

    def self.search(params={})
      response, api_key = ShipHawk::ApiClient.request(:get, '/zip_codes/search', api_key, params)
      ShipHawk::Util.convert_to_ShipHawk_object(response, api_key) if response
    end

  end

end