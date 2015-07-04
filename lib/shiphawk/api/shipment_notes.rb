module Shiphawk
  module Api

    # Company API
    #
    # @see https://shiphawk.com/api-docs
    #
    # The following API actions provide the CRUD interface to managing a company.
    #
    module ShipmentNotes

      def shipment_notes_show shipment_id
        get_request notes_path(shipment_id), {}
      end

      def shipment_notes_update shipment_id, options
        put_request notes_path(shipment_id), options
      end

    end

  end
end