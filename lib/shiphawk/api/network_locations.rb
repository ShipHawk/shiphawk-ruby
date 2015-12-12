module ShipHawk
  module Api

    # NetworkLocations API
    #
    # @see https://shiphawk.com/api-docs
    #
    # The following API actions provide the CRUD interface to manage network locations.
    #

    class NetworkLocations < Resource

      # create a network location and add it to allowed affiliates
      # @params [ company_name ], string, required
      #         [ address ], string, required
      #         [ city ], string, required
      #         [ state ], string, required
      #         [ postal_code ], string, required
      #         [ contact ], string, required
      #         [ email ], string, required
      #         [ fax ], string, optional
      #         [ rating ], string, optional
      #         [ hours_of_operation ], string, optional

      def self.create_network(params={})
        response, api_key = ShipHawk.request(:post, '/network_locations/create_network_location', @api_key, params)
        ShipHawk::Helpers::Util::convert_to_ShipHawk_object(response, api_key) if response
      end

      # assign network location to account
      # @params [ network_location_id ], integer, required

      def self.assign(params={})
        response, api_key = ShipHawk.request(:post, '/network_locations/assign_allowed_affiliate', @api_key, params)
        ShipHawk::Helpers::Util::convert_to_ShipHawk_object(response, api_key) if response
      end

      # remove network location from account
      # @params [ network_location_id ] required

      def self.unassign(params={})
        response, api_key = ShipHawk.request(:post, '/network_locations/remove_allowed_affiliate', @api_key, params)
        ShipHawk::Helpers::Util::convert_to_ShipHawk_object(response, api_key) if response
      end

      # return list of allowed network locations for origin
      def self.allowed
        response, api_key = ShipHawk.request(:get, '/network_locations/allowed_affiliates', @api_key, params)
        ShipHawk::Helpers::Util::convert_to_ShipHawk_object(response, api_key) if response
      end

      # return list of nearest allowed or simply nearest origin network locations for zipcode
      # @params [ zip_code ] required

      def self.closest_to_zip(params={})
        response, api_key = ShipHawk.request(:get, '/network_locations/network_locations_for_zip', @api_key, params)
        ShipHawk::Helpers::Util::convert_to_ShipHawk_object(response, api_key) if response
      end

      # remove network location from account
      # @params [ shipment_id ], required
      #         [ network_location_id ], required

      def self.assign_to_shipment(params={})
        response, api_key = ShipHawk.request(:post, '/network_locations/assign_origin_network_location_to_shipment_format', @api_key, params)
        ShipHawk::Helpers::Util::convert_to_ShipHawk_object(response, api_key) if response
      end


    end

  end
end