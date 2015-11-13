require 'faraday_middleware'
require 'faraday/conductivity'

module Shiphawk
  module Helpers

    module Request

      DEFAULT_HEADERS = {
          'x-li-format' => 'json'
      }

      API_PATH = '/api/'

      attr_reader :connection, :host_url, :adapter, :api_version, :api_token

      %w(get post put patch delete).each do |verb|
        define_method("#{verb}_request") do |endpoint, params|
          conn = get_connection
          response = conn.send(verb, "#{API_PATH}#{api_version}/#{endpoint}", params)
          raise_errors response
          response
        end
      end

      private

      def app_version
        if ENV["APP_VERSION"]
          ENV["APP_VERSION"]
        elsif has_git? && rails_under_git?
          IO.popen(['git', 'rev-parse', 'HEAD', :chdir => Rails.root]).read.chomp
        else
          '0'
        end
      end

      def has_git?
        IO.popen(['which', 'git']).read.chomp.length > 0
      end

      def rails_under_git?
        return false unless defined?(Rails)
        File.exists? (Rails.root + ".git")
      end

      def app_logger
        if defined? Rails
          Rails.logger
        end
      end

      def get_connection
        raise ArgumentError, 'Incorrect connection information' if host_url.nil? || adapter.nil?
        @connection ||= Faraday.new(url: host_url) do |conn|
          conn.request :multipart
          conn.request :url_encoded

          conn.request :user_agent, app: 'ShipHawk Client', version: app_version
          conn.request :request_id
          conn.request :request_headers, accept: 'application/json', 'X-API-KEY' => api_token

          if app_logger
            conn.use :extended_logging, logger: app_logger
          end

          conn.response :json, content_type: /\bjson$/

          conn.adapter adapter
        end
      end

      def raise_errors response
        case response.status.to_i
          when 401
            fail Shiphawk::Errors::UnauthorizedError, "(#{response.status}): #{response.body['error']}"
          when 400
            fail Shiphawk::Errors::GeneralError, "(#{response.status}): #{response.body['error']}"
          when 403
            fail Shiphawk::Errors::AccessDeniedError, "(#{response.status}): #{response.body['error']}"
          when 404
            fail Shiphawk::Errors::NotFoundError, "(#{response.status}): #{response.body['error']}"
          when 422
            fail Shiphawk::Errors::UnprocessableEntityError, "(#{response.status}): #{response.body['error']}"
          when 500
            fail Shiphawk::Errors::InformShiphawkError, "ShipHawk had an internal error. Please send an email to api@shiphawk.com. (#{response.status}): #{response.body['error']}"
          when 502..503
            fail Shiphawk::Errors::UnavailableError, "(#{response.status}): #{response.body['error']}"
        end
      end

    end

  end
end
