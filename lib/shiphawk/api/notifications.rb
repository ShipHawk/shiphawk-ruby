module Shiphawk
  module Api

    # Items API
    #
    # @see https://shiphawk.com/api-docs
    #
    # The following API actions provide the CRUD interface to managing items.
    #
    module Notifications

      def catalog_sale_create options
        post_request catalog_sale_path, options
      end

    end

  end
end
