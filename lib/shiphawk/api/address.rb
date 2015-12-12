module ShipHawk
  module Api

    # Address API
    #
    # @see https://shiphawk.com/api-docs
    #
    # The following API actions provide the CRUD interface to manage addresses.
    #

    class Address < Resource

      def self.search(params={})
        response, api_key = ShipHawk.request(:get, '/addresses/search', api_key, params)
        ShipHawk::Helpers::Util::convert_to_ShipHawk_object(response, api_key) if response
      end

    end

  end
end