module ShipHawk
  module ApiClient
    extend self

    FORMAT = 'x-www-form-urlencoded'
    USER_AGENT = "ShipHawk/#{ShipHawk::Configuration.api_version} RubyClient/#{ShipHawk::Configuration.client_version}"


    def request(method, url, api_key, params={}, headers={}, x_api_key=false)
      headers = {:x_api_key =>  ShipHawk::Configuration.api_key } if x_api_key
      api_key = api_key || ShipHawk::Configuration.api_key
      puts api_key
      raise Error.new('No API key provided.') unless api_key
      params = ShipHawk::Util.objects_to_ids(params)
      url = ShipHawk::Configuration.base_url + url

      case method.to_s.downcase.to_sym
        when :get, :head, :delete
          # Make params into GET parameters
          if params && params.count > 0 && !x_api_key
            query_string = ShipHawk::Util.flatten_params(params).collect{|key, value| "#{key}=#{ShipHawk::Util.url_encode(value)}"}.join('&')
            url += "#{URI.parse(url).query ? '&' : '?'}#{query_string}" + '&api_key=' + api_key
            puts url
          elsif params && params.count > 0 && x_api_key
            query_string = ShipHawk::Util.flatten_params(params).collect{|key, value| "#{key}=#{ShipHawk::Util.url_encode(value)}"}.join('&')
            url += "#{URI.parse(url).query ? '&' : '?'}#{query_string}"
            puts url
          end
          payload = nil
        else
          payload = ShipHawk::Util.flatten_params(params).collect{|(key, value)| "#{key}=#{ShipHawk::Util.url_encode(value)}"}.join('&')
      end

      default_headers = {
          :user_agent => USER_AGENT,
          :authorization => "Bearer #{api_key}",
          :content_type =>  "application/#{FORMAT.downcase}",
      }
      headers = default_headers.merge(headers)
      puts headers
      opts = Configuration.http_config.merge(
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
