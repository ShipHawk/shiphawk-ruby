module ShipHawk
  module Api

    # ApiKeys API
    #
    # @see https://shiphawk.com/api-docs
    #
    # The following API actions provide the CRUD interface to managing api keys.
    #
    class ApiKeys < Resource

          # Get all API keys for an account using an API key
      def api_keys_index
        get_request api_keys_path, {}
      end

    end

  end
end