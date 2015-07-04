module Shiphawk
  module Api

    # Company API
    #
    # @see https://shiphawk.com/api-docs
    #
    # The following API actions provide the CRUD interface to managing multiple shipments by setting status.
    #
    module ShipmentTracking

      def shipments_status_show shipment_id
        get_request tracking_path(shipment_id)
      end

      def shipments_status_update shipment_id, options
        put_request tracking_path(shipment_id), options
      end

    end

  end
end