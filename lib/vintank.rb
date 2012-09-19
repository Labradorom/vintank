require 'vintank/version'
require 'vintank/error'
require 'vintank/configuration'
require 'vintank/api'
require 'vintank/client'
#require 'vintank/search'
#require 'vintank/base'

module Vintank
  extend Configuration

  # Alias for Vintank::Client.new
  #
  # @return [Vintank::Client]
  def self.client(options={})
    Vintank::Client.new(options)
  end

  # Delegate to Vintank::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  # Delegate to Vintank::Client
  def self.respond_to?(method)
    return client.respond_to?(method) || super
  end
end