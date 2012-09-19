require 'helper'

describe Vintank::Client do
  Vintank::Configuration::VALID_FORMATS.each do |format|
    context ".new(:format => '#{format}')" do
      before do
        @client = Vintank::Client.new(:format => format, :app_id => 'CK', :secret => 'CS')
      end

      describe ".wine_search" do

        context "with query passed" do

          before do
            stub_get("search/wines").
              with(:query => {:fmt => format, :q => "rodney"}).
              to_return(:body => fixture("wines.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.wine_search("rodney")
            a_get("search/wines").
              with(:query => {:fmt => format, :q => "rodney"}).
              should have_been_made
          end

          it "should return the top 50 wines matching the search criteria" do
            wines = @client.wine_search("rodney")
            wines.results.should be_an Array
            wines.results.first.name.should == "2006 Black Cloud Pinot Noir Black Cloud Okanagan Valley"
          end

        end

      end

    end
  end
end
