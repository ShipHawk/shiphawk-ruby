require 'faraday_middleware'

module Shiphawk
  module Helpers

    module Request

      DEFAULT_HEADERS = {
          'x-li-format' => 'json'
      }

      API_PATH = '/api/v3/'

      attr_reader :connection, :host_url, :adapter

      %w(get post put patch delete).each do |verb|
        define_method("#{verb}_request") do |endpoint, params|
          conn = get_connection
          response = conn.send(verb, "#{API_PATH}#{endpoint}", params)
          raise_errors response
          response
        end
      end

      private

      def get_connection
        raise ArgumentError, 'Incorrect connection information' if host_url.nil? || adapter.nil?
        @connection ||= Faraday.new(url: host_url) do |conn|
          conn.request  :json
          conn.response :json, content_type: /\bjson$/
          conn.adapter  adapter
        end
      end

      def raise_errors response
        case response.code.to_i
          when 401
            raise Shiphawk::Errors::UnauthorizedError, "(#{response.status}): #{response.message}"
          when 400
            raise Shiphawk::Errors::GeneralError, "(#{response.status}): #{response.message}"
          when 403
            raise Shiphawk::Errors::AccessDeniedError, "(#{response.status}): #{response.message}"
          when 404
            raise Shiphawk::Errors::NotFoundError, "(#{response.code}): #{response.message}"
          when 422
            raise Shiphawk::Errors::UnprocessableEntityError, "(#{response.code}): #{response.message}"
          when 500
            raise Shiphawk::Errors::InformShiphawkError, "ShipHawk had an internal error. Please send an email to api@shiphawk.com. (#{response.code}): #{response.message}"
          when 502..503
            raise Shiphawk::Errors::UnavailableError, "(#{response.code}): #{response.message}"
        end
      end

    end

  end
end
