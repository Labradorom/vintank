require 'faraday'
require 'vintank/version'

module Vintank
  # Defines constants and methods related to configuration
  module Configuration
    # An array of valid keys in the options hash when configuring a {Vintank::API}
    VALID_OPTIONS_KEYS = [
      :adapter,
      :app_id,
      :secret,
      :endpoint,
      :format,
      :user_agent].freeze

    # An array of valid request/response formats
    VALID_FORMATS = [
      :json].freeze

    # The adapter that will be used to connect if none is set
    #
    # @note The default faraday adapter is Net::HTTP.
    DEFAULT_ADAPTER = Faraday.default_adapter

    # By default, don't set an app id
    DEFAULT_APP_ID = nil

    # By default, don't set a secret
    DEFAULT_SECRET = nil

    # The endpoint that will be used to connect if none is set
    #
    # @note This is configurable in case you want to use HTTP instead of HTTPS, specify a different API version, or use a Cruvee-compatible endpoint.
    DEFAULT_ENDPOINT = 'http://apiv1.cruvee.com/'.freeze

    # The response format appended to the path and sent in the 'Accept' header if none is set
    #
    # @note JSON is preferred over XML because it is more concise and faster to parse.
    DEFAULT_FORMAT = :json

    # The user agent that will be sent to the API endpoint if none is set
    DEFAULT_USER_AGENT = "Vintank Ruby Gem #{Vintank::VERSION}".freeze

    # @private
    attr_accessor *VALID_OPTIONS_KEYS

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    # Create a hash of options and their values
    def options
      Hash[VALID_OPTIONS_KEYS.map {|key| [key, send(key)] }]
    end

    # Reset all configuration options to defaults
    def reset
      self.adapter            = DEFAULT_ADAPTER
      self.app_id             = DEFAULT_APP_ID
      self.secret             = DEFAULT_SECRET
      self.endpoint           = DEFAULT_ENDPOINT
      self.format             = DEFAULT_FORMAT
      self.user_agent         = DEFAULT_USER_AGENT
      self
    end
  end
end