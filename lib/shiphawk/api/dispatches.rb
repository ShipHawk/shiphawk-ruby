module ShipHawk
  module Api

    # Dispatch API
    #
    # @see https://shiphawk.com/api-docs
    #
    # The following API actions provide the CRUD interface to manage dispatches.
    #

    class Dispatches < Resource

      # create a dispatch
      # @params [ shipment_id ], integer, required
      #         [ pickup_start_time ], string, required ex. "2015-12-11T00:42:09Z"
      #         [ pickup_end_time ], string, required ex. "2015-12-13T00:42:09Z",
      #         [ instructions ], string optional

      def self.build(params={})
        response, api_key = ShipHawk::Client.request(:post, '/dispatches', @api_key, params)
        ShipHawk::Helpers::Util::convert_to_ShipHawk_object(response, api_key) if response
      end
    end

  end
end

