module ShipHawk
  module Api

    # Zip Codes API
    #
    # @see https://shiphawk.com/api-docs
    #
    # The following API actions provide the CRUD interface to managing zip codes.
    #

    class ZipCodes < Resource

      def self.search(params={})
        response, api_key = ShipHawk.request(:get, '/zip_codes/search', @api_key, params)
        ShipHawk::Helpers::Util::convert_to_ShipHawk_object(response, api_key) if response
      end

    end

  end
end