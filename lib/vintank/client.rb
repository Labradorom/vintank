module Vintank
  # Wrapper for the Vintank API
  #
  # @note All methods have been separated into modules
  # @see http://developer.cruvee.com/search-api/
  class Client < API
    # Require client method modules after initializing the Client class in
    # order to avoid a superclass mismatch error, allowing those modules to be
    # Client-namespaced.
    require 'vintank/client/utils'
    require 'vintank/client/wine_search'
    require 'vintank/client/wine_details'

    alias :api_endpoint :endpoint

    include Vintank::Client::Utils

    include Vintank::Client::WineSearch
    include Vintank::Client::WineDetails
  end
end
