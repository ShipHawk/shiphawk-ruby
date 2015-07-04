module Shiphawk
  module Api

    # Zip Codes API
    #
    # @see https://shiphawk.com/api-docs
    #
    # The following API actions provide the CRUD interface to managing zip codes.
    #
    module ZipCodes

      def zip_codes_index
        collection_request zip_codes_path, 1000
      end

      def zip_codes_search options
        entity_request_with_options zip_codes_path('search'), q: options.fetch(:q, '')
      end

    end

  end
end