module Shiphawk
  module Api

    # Company API
    #
    # @see https://shiphawk.com/api-docs
    #
    # The following API actions provide the CRUD interface to managing a shipment's tracking.
    #
    module ShipmentsStatus

      def shipments_status_update options
        put_request status_path, options
      end

    end

  end
end
