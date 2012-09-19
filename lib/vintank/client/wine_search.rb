module Vintank
  class Client
    # Defines methods related to wine searching
    module WineSearch
      # Returns the 10 wines matching the provided criteria
      #
      # @overload wine_search(query, options={})
      #   @param query [String] The search query.
      #   @param options [Hash] A customizable set of options.
      #   @option options [Integer] :rpp The number of wines to be returned (maximum of 50)
      #   @option options [Integer] :page The page in the search results
      #   @return [Array]
      #   @example Return the 10 wines containing the term "Rodney"
      #     Vintank.wine_Search("rodney")
      # @note This method can only return up to 50 wines.
      # @format :json, :html
      # @see http://developer.cruvee.com/search-api/
      def wine_search(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        query = args.first
        merge_query_into_options!(query, options)
        response = get('search/wines', options)
        format.to_s.downcase == 'html' ? response['statuses'] : response
      end
    end
  end
end
