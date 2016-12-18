require 'active_support'
require 'chrono'
require 'forwardable'
require 'hashie'
require 'termcolor'
require 'thor'
require 'logger'
require 'flexirest'

module Remoppy
  class << self
    extend Forwardable

    def_delegators :configuration, :logger
    def_delegators :client, :start, :hello, :hear, :say, :schedule, :monitor, :goodnight, :respond

    def configure
      @configuration = Configuration.new

      yield configuration if block_given?

      configuration
    end

    def configuration
      @configuration || configure
    end

    def client
      @client ||= Client.new
    end
  end
end

require 'remoppy/concerns/debuggable'
require 'remoppy/remotty/api'
require 'remoppy/cli'
require 'remoppy/client'
require 'remoppy/configuration'
require 'remoppy/configuration/robot'
require 'remoppy/commands/generator.rb'
require 'remoppy/commands/run.rb'
require 'remoppy/event'
require 'remoppy/listener'
require 'remoppy/messenger'
require 'remoppy/schedule'
require 'remoppy/version'
