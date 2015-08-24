module Shiphawk

  class << self
    # config/initializers/shiphawk.rb (for instance)
    #
    # ```ruby
    # Shiphawk.configure do |config|
    #   config.token = 'api_token'
    # end
    # ```
    # elsewhere
    #
    # ```ruby
    # client = ShiphawkClient::Client.new
    # ```
    #
    # You can also chose to use the class as a singleton
    #
    # ```ruby
    # Shiphawk.{method_name}
    # ```

    def configure
      yield self
      true
    end

    def method_missing(method, *args, &block)
      return super unless self::Client.new.respond_to?(method)
      self::Client.new.send(method, *args, &block)
    end

    attr_accessor :api_token, :sandbox
  end

  autoload :Api,     'shiphawk/api'
  autoload :Client,  'shiphawk/client'
  autoload :Mash,    'shiphawk/mash'
  autoload :Errors,  'shiphawk/errors'
  autoload :Helpers, 'shiphawk/helpers'
  autoload :Version, 'shiphawk/version'

end
