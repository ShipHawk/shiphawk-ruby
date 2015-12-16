module ShipHawk
  # Address API
  #
  # @see https://shiphawk.com/api-docs
  #
  # The following API actions provide the CRUD interface to manage addresses.
  #
  class Addresses < Resource

    def self.search(params={})
      response, api_key = ShipHawk::ApiClient.request(:get, '/addresses/search', @api_key, params)
      JSON.parse(response.to_json) if response
    end
  end
end