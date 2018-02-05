module Shiphawk
  module Api

    # Shipments API
    #
    # @see https://shiphawk.com/api-docs
    #
    # The following API actions provide the CRUD interface to managing Shipments.
    #
    module Shipments

      def shipments_index
        collection_request shipments_path, 500
      end

      def shipments_show shipment_id
        entity_request_with_id shipments_path, shipment_id
      end

      def shipments_labels shipment_id
        get_request shipments_path("#{shipment_id}/labels"), {}
      end

      def shipments_bol shipment_id
        get_request shipments_path("#{shipment_id}/bol"), {}
      end

      def shipments_bol_pdf shipment_id
        get_request shipments_path("#{shipment_id}/bol.pdf"), {}
      end

      def shipments_create options
        post_request shipments_path, options
      end

      def shipments_update shipment_id, options
        put_request shipments_path(shipment_id), options
      end

      def shipments_destroy shipment_id
        delete_request shipments_path(shipment_id), {}
      end

    end

  end
end
