require 'faraday'

# @private
module Faraday
  # @private
  class Response::RaiseHttp5xx < Response::Middleware
    def self.register_on_complete(env)
      env[:response].on_complete do |response|
        case response[:status].to_i
        when 500
          raise Vintank::InternalServerError, error_message(response, "Something is technically wrong.")
        when 502
          raise Vintank::BadGateway, error_message(response, "Vintank is down or being upgraded.")
        when 503
          raise Vintank::ServiceUnavailable, error_message(response, "(__-){ Vintank is over capacity.")
        end
      end
    end

    def initialize(app)
      super
      @parser = nil
    end

    private

    def self.error_message(response, body=nil)
      "#{response[:method].to_s.upcase} #{response[:url].to_s}: #{[response[:status].to_s + ':', body].compact.join(' ')} "
    end
  end
end
