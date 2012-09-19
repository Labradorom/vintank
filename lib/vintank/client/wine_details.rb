module Vintank
  class Client
    # Defines methods related to wine details
    module WineDetails
      # Returns the full details of a specified wine
      #
      # @overload wine_search(query, options={})
      #   @param yn_id [String] The ynid of the wine.
      #   @return [Hash]
      #   @example Return the details for a wine
      #     Vintank.wine_details("124000200077801200600100")
      # @format :json, :html
      # @see http://developer.cruvee.com/search-api/
      def wine_details(yn_id)
        extension = format.to_s.downcase == 'json' ? '.js' : ''
        response = get("wines/#{yn_id}#{extension}")
        format.to_s.downcase == 'html' ? response['statuses'] : response
      end
    end
  end
end
