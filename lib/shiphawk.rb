module Shiphawk

  class << self
    # config/initializers/shiphawk.rb (for instance)
    #
    # ```ruby
    # ShiphawkClient.configure do |config|
    #   config.token = 'api_token'
    # end
    # ```
    # elsewhere
    #
    # ```ruby
    # client = ShiphawkClient::Client.new
    # ```
    def configure
      yield self
      true
    end

  end

  autoload :Api,     'shiphawk/api'
  autoload :Client,  'shiphawk/client'
  autoload :Mash,    'shiphawk/mash'
  autoload :Errors,  'shiphawk/errors'
  autoload :Helpers, 'shiphawk/helpers'
  autoload :Version, 'shiphawk/version'

end
