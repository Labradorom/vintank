require 'helper'

describe Vintank::Client do
  Vintank::Configuration::VALID_FORMATS.each do |format|
    context ".new(:format => '#{format}')" do
      before do
        @client = Vintank::Client.new(:format => format, :app_id => 'CK', :secret => 'CS')
      end

      describe ".wine_details" do

        context "with yn_id passed" do
          extension = format.to_s.downcase == 'json' ? '.js' : ''

          before do
            stub_get("wines/124000200077801200600100#{extension}").
              with(:query => {:fmt => format}).
              to_return(:body => fixture("wine_details.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.wine_details("124000200077801200600100")
            a_get("wines/124000200077801200600100#{extension}").
              with(:query => {:fmt => format}).
              should have_been_made
          end

          it "should return the wine details" do
            wine = @client.wine_details("124000200077801200600100")
            wine.should be_a Hash
            wine.name.should == "2006 Black Cloud Pinot Noir Black Cloud Okanagan Valley"
            wine.ABV.should == 13.2
          end

        end

      end

    end
  end
end
