module Shiphawk
  module Errors

    class ShiphawkError < StandardError
      attr_reader :data
      def initialize(data)
        @data = data
        super
      end
    end

    # Raised when a 401 response status code is received
    class UnauthorizedError   < ShiphawkError; end

    # Raised when a 400 response status code is received
    class GeneralError        < ShiphawkError; end

    # Raised when a 403 response status code is received
    class AccessDeniedError   < ShiphawkError; end

    # Raised when a 404 response status code is received
    class NotFoundError       < ShiphawkError; end

    # Raised when a 422 response status code is received
    class UnprocessableEntityError  < ShiphawkError; end

    # Raised when a 500 response status code is received
    class InformShiphawkError < ShiphawkError; end

    # Raised when a 502 or 503 response status code is received
    class UnavailableError    < ShiphawkError; end

  end
end