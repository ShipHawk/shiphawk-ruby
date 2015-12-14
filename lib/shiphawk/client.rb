module ShipHawk
  module Client
    extend self
    DEFAULT_API_VERSION = 'v3'
    PRODUCTION_API_HOST = 'https://shiphawk.com/api/v3'
    SANDBOX_API_HOST = 'https://sandbox.shiphawk.com/api/v3'
    OPEN_TIMEOUT = 30
    TIMEOUT = 60
    SSL_VERSION = 'TLSv1'
    @@api_base = PRODUCTION_API_HOST

    def api_url=(url)
      @api_url = @api_base + url
    end

    def api_url
      @api_url
    end

    def api_key=(api_key)
      @api_key = api_key
    end

    def api_key
      @api_key
    end

    def api_base
      @@api_base ||= API_BASE
    end

    def api_base=(api_base_url)
      @@api_base = api_base_url
    end


    def api_version=(version)
      @api_version = version
    end

    def api_version
      @api_version ||= DEFAULT_API_VERSION
    end

    def http_config
      @http_config ||= {
          timeout: TIMEOUT,
          open_timeout: OPEN_TIMEOUT,
          verify_ssl: false,
          ssl_version: SSL_VERSION
      }
    end

    def http_config=(http_config_params)
      http_config.merge!(http_config_params)
    end

    def request(method, url, api_key, params={}, headers={})
      api_key ||= @api_key
      raise Error.new('No API key provided.') unless api_key
      params = ShipHawk::Helpers::Util.objects_to_ids(params)
      url = @@api_base + url
      case method.to_s.downcase.to_sym
        when :get, :head, :delete
          # Make params into GET parameters
          if params && params.count > 0
            query_string = ShipHawk::Helpers::Util.flatten_params(params).collect{|key, value| "#{key}=#{ShipHawk::Helpers::Util.url_encode(value)}"}.join('&')
            url += "#{URI.parse(url).query ? '&' : '?'}#{query_string}" + '&api_key=' + api_key
            puts url
          end
          payload = nil
        else
          payload = ShipHawk::Helpers::Util.flatten_params(params).collect{|(key, value)| "#{key}=#{ShipHawk::Helpers::Util.url_encode(value)}"}.join('&')
      end

      headers = {
          :user_agent => "ShipHawk/v3 RubyClient/#{VERSION}",
          :authorization => "Bearer #{api_key}",
          :content_type => 'application/x-www-form-urlencoded'
      }.merge(headers)

      opts = http_config.merge(
          {
              :method => method,
              :url => url + '?api_key=' + api_key,
              :headers => headers,
              :payload => payload
          }
      )

      begin
        response = execute_request(opts)
      rescue RestClient::ExceptionWithResponse => e
        if response_code = e.http_code and response_body = e.http_body
          begin
            response_json = MultiJson.load(response_body, :symbolize_keys => true)
          rescue MultiJson::DecodeError
            raise Error.new("Invalid response from API, unable to decode.", response_code, response_body)
          end
          begin
            raise NoMethodError if response_json[:error][:message] == nil
            raise Error.new(response_json[:error][:message], response_code, response_body, response_json)
          rescue NoMethodError, TypeError
            raise Error.new(response_json[:error], response_code, response_body, response_json)
          end
        else
          raise Error.new(e.message)
        end
      rescue RestClient::Exception, Errno::ECONNREFUSED => e
        raise Error.new(e.message)
      end

      begin
        response_json = MultiJson.load(response.body, :symbolize_keys => true)
      rescue MultiJson::DecodeError
        raise Error.new("Invalid response object from API, unable to decode.", response.code, response.body)
      end

      [response_json, api_key]
    end

    private

    def execute_request(opts)
      RestClient::Request.execute(opts)
    end
  end
end
