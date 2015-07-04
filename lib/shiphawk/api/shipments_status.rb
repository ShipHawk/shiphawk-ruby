module Shiphawk
  module Api

    # Company API
    #
    # @see https://shiphawk.com/api-docs
    #
    # The following API actions provide the CRUD interface to managing a shipment's tracking.
    #
    module ShipmentsStatus

      def shipments_status_update shipment_id, options
        put_request status_path(shipment_id), options
      end

    end

  end
end