module Shiphawk
  module Api

    # Products API
    #
    # @see https://shiphawk.com/api-docs
    #
    # The following API actions provide the CRUD interface to managing products.
    #
    module Products

      def products_show product_sku
        entity_request_with_id products_path, product_sku
      end

      def products_create options
        post_request products_path, options
      end

      def products_update product_sku, options
        put_request products_path(product_sku), options
      end

      def products_destroy product_sku
        delete_request products_path(product_sku), {}
      end
    end

  end
end