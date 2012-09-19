module Vintank
  # Defines HTTP request methods
  module Request
    # Perform an HTTP GET request
    def get(path, options={}, raw=false)
      request(:get, path, options, raw)
    end

    private

    # Perform an HTTP request
    def request(method, path, options, raw=false)
      response = connection(raw).send(method) do |request|
        case method
        when :get
          request.url(path, formatted_options(options))
        end
      end
      raw ? response : response.body
    end

    def formatted_options(options)
      options[:fmt] = format
      options
    end
  end
end
