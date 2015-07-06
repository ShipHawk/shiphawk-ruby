module Shiphawk
  module Api

    # Categories API
    #
    # @see https://shiphawk.com/api-docs
    #
    # The following API actions provide the CRUD interface to managing categories.
    #
    module Categories

      def categories_index
        collection_request categories_path, 500
      end

      def categories_show category_id
        entity_request_with_id categories_path, category_id
      end

      def categories_create options
        post_request categories_path, options
      end

      def categories_update category_id, options
        put_request categories_path(category_id), options
      end

      def categories_destroy category_id
        delete_request categories_path, id: category_id
      end
    end

  end
end