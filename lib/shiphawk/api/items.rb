module Shiphawk
  module Api

    # Items API
    #
    # @see https://shiphawk.com/api-docs
    #
    # The following API actions provide the CRUD interface to managing items.
    #
    module Items

      def items_index
        collection_request items_path, 500
      end

      def items_show options
        entity_request_with_id items_path, id: options[:id]
      end

      def items_search options
        entity_request_with_options items_path('autocomplete'), q: options.fetch(:q, '')
      end

    end

  end
end