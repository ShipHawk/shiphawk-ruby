# Common files
require 'cgi'
require 'set'
require 'openssl'
require 'rest_client'
require 'multi_json'

# Resources
require 'shiphawk/configuration'
require 'shiphawk/version'
require 'shiphawk/helpers/util'
require 'shiphawk/api_client'
require 'shiphawk/error'

# APIs
require 'shiphawk/api/object'
require 'shiphawk/api/resource'
require 'shiphawk/api/api_keys'
require 'shiphawk/api/addresses'
require 'shiphawk/api/shipments'
require 'shiphawk/api/rates'
require 'shiphawk/api/items'
require 'shiphawk/api/zip_codes'
require 'shiphawk/api/network_locations'
require 'shiphawk/api/dispatches'
require 'shiphawk/api/carriers'
require 'shiphawk/api/products'
require 'shiphawk/api/categories'
require 'shiphawk/api/public'



module ShipHawk
  class << self
    # Configure sdk using block.
    # ShipHawk.configure do |config|
    #   config.api_key  = "xxx"
    #   config.username = "xxx"
    #   config.password = "xxx"
    # end
    # If no block given, return the configuration singleton instance.
    def configure
      if block_given?
        yield Configuration.instance
      else
        Configuration.instance
      end
    end
  end
end
