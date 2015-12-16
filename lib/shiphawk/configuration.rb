require 'uri'
require 'singleton'

module ShipHawk
  class Configuration

    include Singleton

    # Default api client
    attr_accessor :api_client

    # Defines url scheme
    attr_accessor :scheme

    # Defines url host
    attr_accessor :host

    # Defines url base path
    attr_accessor :base_path

    # Defines base_url
    attr_accessor :base_url

    # Defines api version
    attr_accessor :api_version

    # Defines client version
    attr_accessor :client_version

    # Defines API keys used with API Key authentications.
    #
    # @return [Hash] key: parameter name, value: parameter value (API key)
    #
    # @example parameter name is "api_key", API key is "xxx" (e.g. "api_key=xxx" in query string)
    #   config.api_key['api_key'] = 'xxx'
    attr_accessor :api_key

    # Defines API key prefixes used with API Key authentications.
    #
    # @return [Hash] key: parameter name, value: API key prefix
    #
    # @example parameter name is "Authorization", API key prefix is "Token" (e.g. "Authorization: Token xxx" in headers)
    #   config.api_key_prefix['api_key'] = 'Token'
    attr_accessor :api_key_prefix

    # Defines the username used with HTTP basic authentication.
    #
    # @return [String]
    attr_accessor :username

    # Defines the password used with HTTP basic authentication.
    #
    # @return [String]
    attr_accessor :password

    # Defines the access token (Bearer) used with OAuth2.
    attr_accessor :access_token

    # Set this to enable/disable debugging. When enabled (set to true), HTTP request/response
    # details will be logged with `logger.debug` (see the `logger` attribute).
    # Default to false.
    #
    # @return [true, false]
    attr_accessor :debugging

    # Defines the logger used for debugging.
    # Default to `Rails.logger` (when in Rails) or logging to STDOUT.
    #
    # @return [#debug]
    attr_accessor :logger

    # Defines the temporary folder to store downloaded files
    # (for API endpoints that have file response).
    # Default to use `Tempfile`.
    #
    # @return [String]
    attr_accessor :temp_folder_path

    ### TLS/SSL
    # Set this to false to skip verifying SSL certificate when calling API from https server.
    # Default to true.
    #
    # @note Do NOT set it to false in production code, otherwise you would face multiple types of cryptographic attacks.
    #
    # @return [true, false]
    attr_accessor :verify_ssl
    attr_accessor :timeout
    attr_accessor :open_timeout
    attr_accessor :ssl_version
    attr_accessor :sandbox
    attr_accessor :production


    class << self
      def method_missing(method_name, *args, &block)
        config = Configuration.instance
        if config.respond_to?(method_name)
          config.send(method_name, *args, &block)
        else
          super
        end
      end
    end

    def initialize
      @scheme = 'https'
      @host = 'shiphawk.com'
      @sandbox = 'sandbox.shiphawk.com'
      @production = 'shiphawk.com'
      @base_path = 'api'
      @api_version = 'v3'
      @client_version = '1.0.0'
      @api_key_prefix = nil
      @timeout = 60
      @verify_ssl = false
      @open_timeout = 30
      @ssl_version = 'TLSv1'
      @api_url = nil
      @debugging = false
      @logger = defined?(Rails) ? Rails.logger : Logger.new(STDOUT)
    end


    def http_config
      @http_config ||= {
          timeout: timeout,
          open_timeout: open_timeout,
          verify_ssl: verify_ssl,
          ssl_version: ssl_version
      }
    end

    def http_config=(http_config_params)
      http_config.merge!(http_config_params)
    end


    def api_client
      @client ||= ShipHawk::ApiClient.new
    end

    def scheme=(scheme)
      # remove :// from scheme
      @scheme = scheme.sub(/:\/\//, '')
    end

    def host=(host)
      # remove http(s):// and anything after a slash
      @host = host.sub(/https?:\/\//, '').split('/').first
    end

    def base_path=(base_path)
      # Add leading and trailing slashes to base_path
      @api_base = "/#{base_path}".gsub(/\/+/, '/')
      @api_base = "" if @base_path == "/"
    end

    def api_version=(version)
      @api_version = version
    end


    def base_url
      url = "#{scheme}://#{[host, base_path, api_version].join('/').gsub(/\/+/, '/')}".sub(/\/+\z/, '')
      URI.encode(url)
    end

    # Gets API key (with prefix if set).
    # @param [String] param_name the parameter name of API key auth
    def api_key_with_prefix(param_name)
      if @api_key_prefix[param_name]
        "#{@api_key_prefix[param_name]} #{@api_key[param_name]}"
      else
        @api_key[param_name]
      end
    end

    # Gets Basic Auth token string
    def basic_auth_token
      'Basic ' + ["#{username}:#{password}"].pack('m').delete("\r\n")
    end

    # Returns Auth Settings hash for api client.
    def auth_settings
      {
      }
    end
  end
end
