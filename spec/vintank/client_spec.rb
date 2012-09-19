require 'helper'

describe Vintank::Client do
  it "should connect using the endpoint configuration" do
    client = Vintank::Client.new
    endpoint = URI.parse(client.api_endpoint)
    connection = client.send(:connection).build_url(nil).to_s
    connection.should == endpoint.to_s
  end
end
