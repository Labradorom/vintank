require 'vintank'
require 'rspec'
require 'webmock/rspec'
RSpec.configure do |config|
  config.include WebMock::API
end

def a_delete(path)
  a_request(:delete, Vintank.endpoint + path)
end

def a_get(path)
  a_request(:get, Vintank.endpoint + path)
end

def a_post(path)
  a_request(:post, Vintank.endpoint + path)
end

def a_put(path)
  a_request(:put, Vintank.endpoint + path)
end

def stub_delete(path)
  stub_request(:delete, Vintank.endpoint + path)
end

def stub_get(path)
  stub_request(:get, Vintank.endpoint + path)
end

def stub_post(path)
  stub_request(:post, Vintank.endpoint + path)
end

def stub_put(path)
  stub_request(:put, Vintank.endpoint + path)
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end
