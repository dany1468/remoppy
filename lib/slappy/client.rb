require 'slack'
require 'slappy/event'
require 'slappy/listener'

module Slappy
  class Client
    def initialize(token)
      Slack.configure { |config| config.token = token }
      @client = Slack.realtime
      @listeners = {}
    end

    def start
      @listeners.each do |key, array|
        @client.on key do |data|
          array.each do |listener|
            event = Event.new(data, listener.pattern) if key == :message
            listener.call(event)
          end
        end
      end
      @client.start
    end

    def hello(&block)
      @listeners[:hello] ||= []
      @listeners[:hello].push block
    end

    def hear(regexp, &block)
      @listeners[:message] ||= []
      @listeners[:message].push Listener.new(regexp, block)
    end
  end
end