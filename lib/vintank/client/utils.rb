# -*- encoding: utf-8 -*-
module Vintank
  class Client
    # @private
    module Utils
      private

      # Take a single query value and merge it into an options hash with the correct key
      #
      # @param query [String] The search query.
      # @param options [Hash] A customizable set of options.
      # @return [Hash]
      def merge_query_into_options!(query, options={})
        options[:q] = query
        options
      end
    end
  end
end
