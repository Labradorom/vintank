require 'helper'

describe Vintank do
  after do
    Vintank.reset
  end

  context "when delegating to a client" do

    before do
      stub_get("search/wines").
        with(:query => {:fmt => Vintank.client.format, :q => "rodney"}).
        to_return(:body => fixture("wines.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end

    it "should get the correct resource" do
      Vintank.wine_search('rodney')
      a_get("search/wines").
        with(:query => {:fmt => Vintank.client.format, :q => "rodney"}).
        should have_been_made
    end

    it "should return the same results as a client" do
      Vintank.wine_search('rodney').should == Vintank::Client.new.wine_search('rodney')
    end

  end

  describe ".client" do
    it "should be a Vintank::Client" do
      Vintank.client.should be_a Vintank::Client
    end
  end

  describe ".adapter" do
    it "should return the default adapter" do
      Vintank.adapter.should == Vintank::Configuration::DEFAULT_ADAPTER
    end
  end

  describe ".adapter=" do
    it "should set the adapter" do
      Vintank.adapter = :typhoeus
      Vintank.adapter.should == :typhoeus
    end
  end

  describe ".endpoint" do
    it "should return the default endpoint" do
      Vintank.endpoint.should == Vintank::Configuration::DEFAULT_ENDPOINT
    end
  end

  describe ".endpoint=" do
    it "should set the endpoint" do
      Vintank.endpoint = 'http://tumblr.com/'
      Vintank.endpoint.should == 'http://tumblr.com/'
    end
  end

  describe ".format" do
    it "should return the default format" do
      Vintank.format.should == Vintank::Configuration::DEFAULT_FORMAT
    end
  end

  describe ".format=" do
    it "should set the format" do
      Vintank.format = 'xml'
      Vintank.format.should == 'xml'
    end
  end

  describe ".user_agent" do
    it "should return the default user agent" do
      Vintank.user_agent.should == Vintank::Configuration::DEFAULT_USER_AGENT
    end
  end

  describe ".user_agent=" do
    it "should set the user_agent" do
      Vintank.user_agent = 'Custom User Agent'
      Vintank.user_agent.should == 'Custom User Agent'
    end
  end

  describe ".configure" do

    Vintank::Configuration::VALID_OPTIONS_KEYS.each do |key|

      it "should set the #{key}" do
        Vintank.configure do |config|
          config.send("#{key}=", key)
          Vintank.send(key).should == key
        end
      end
    end
  end
end
