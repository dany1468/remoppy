module Remoppy
  class Messenger
    class MissingChannelException < StandardError; end

    CHANNEL_APIS = [Remoppy::Remotty::Api::Participation]

    def initialize(options = {})
      opt = options.dup
      @destination = {}
      @destination = opt.delete(:channel)
      @options = opt
    end

    def message
      options = merge_params(@options)

      Remoppy::Remotty::Api::Comment.create(participations_id: @destination, comment: {content: options[:text], all: false})

      # fail SlackAPI::SlackError.new, response['error'] unless response['ok']
    end

    private

    def config
      Remoppy.configuration
    end

    def merge_params(options)
      default = config.send_params
      default.merge options
    end
  end
end
