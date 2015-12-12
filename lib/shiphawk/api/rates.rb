module ShipHawk
  module Api

    # Rates API
    #
    # @see https://shiphawk.com/api-docs
    #
    # The following API actions provide the CRUD interface to managing rates.
    #
    module Rates

      # Retrieve rates using a Rates ID key
      def rates_show rate_id
        entity_request_with_id rates_path, rate_id
      end

      # Obtain rates given a source
      def rates_create options
        post_request rates_path, options
      end

    end

  end
end