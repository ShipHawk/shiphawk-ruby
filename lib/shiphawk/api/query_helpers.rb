module Shiphawk
  module Api

    module QueryHelpers

      def items_path sub_path=nil
        "items/#{sub_path}"
      end

      def categories_path sub_path=nil
        "categories/#{sub_path}"
      end

      def products_path sub_path=nil
        "products/#{sub_path}"
      end

      def rates_path sub_path=nil
        "rates/#{sub_path}"
      end

      def notes_path id
        shipments_path "#{id}/notes"
      end

      def tracking_path id
        shipments_path "#{id}/tracking"
      end

      def shipments_path sub_path=nil
        "shipments/#{sub_path}"
      end

      def status_path
        shipments_path "status"
      end

      def zip_codes_path sub_path=nil
        "zip_codes/#{sub_path}"
      end

      def collection_request path, count=100
        page = 1
        entities = []
        loop do
          response = get_request path, {page: page, per_page: count, api_token: self.api_token}
          entities << response.body
          entities = entities.flatten
          break if entities.size >= response.headers['X-Total'].to_i
          page += 1
        end
        entities
      end

      def entity_request_with_id path, id
        get_request "#{path}#{id}", {}
      end

      def entity_request_with_options path, options
        get_request path, options
      end

    end

  end
end
