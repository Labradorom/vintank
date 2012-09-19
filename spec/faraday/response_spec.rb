require 'helper'

describe Faraday::Response do
  before do
    @client = Vintank::Client.new
  end

  {
    400 => Vintank::BadRequest,
    401 => Vintank::Unauthorized,
    403 => Vintank::Forbidden,
    404 => Vintank::NotFound,
    406 => Vintank::NotAcceptable,
    500 => Vintank::InternalServerError,
    502 => Vintank::BadGateway,
    503 => Vintank::ServiceUnavailable,
  }.each do |status, exception|
    context "when HTTP status is #{status}" do

      before do
        stub_get('search/wines').
          with(:query => {:fmt => @client.format, :q => 'rodney'}).
          to_return(:status => status)
      end

      it "should raise #{exception.name} error" do
        lambda do
          @client.wine_search('rodney')
        end.should raise_error(exception)
      end
    end
  end
end
