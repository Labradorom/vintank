require 'faraday'
require 'digest/md5'

# @private
module Faraday
  # @private
  class Request::HeaderAuthentication < Faraday::Middleware
    def call(env)
      params = env[:body].is_a?(Hash) ? env[:body] : {}
      params[:appId] = @options[:app_id]
      timestamp = Time.now.to_i * 1000
      params[:timestamp] = timestamp
      params[:uri] = env[:url].path
      params[:sig] = build_signature(env, timestamp)

      header_string = "Cruvee appId=\"#{params[:appId]}\", sig=\"#{params[:sig]}\", timestamp=\"#{params[:timestamp]}\", uri=\"#{params[:uri]}\""
      env[:request_headers]['Authorization'] = header_string

      @app.call(env)
    end

    def build_signature(env, timestamp)
      sig = "#{@options[:app_id]}\n#{env[:method]}\n#{@options[:secret]}\n#{timestamp}\n#{env[:url].path}\n"
      Digest::MD5.hexdigest(sig.downcase)
    end

    def initialize(app, options)
      @app, @options = app, options
    end
  end
end
