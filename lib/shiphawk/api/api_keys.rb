module Shiphawk
  module Api

    # ApiKeys API
    #
    # @see https://shiphawk.com/api-docs
    #
    # The following API actions provide the CRUD interface to managing api keys.
    #
    module ApiKeys

      #
      # Get all API keys for a company
      def api_keys_index
        get_request api_keys_path
      end

    end

  end
end