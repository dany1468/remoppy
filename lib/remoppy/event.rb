module Remoppy
  class Event
    extend Forwardable
    include Debuggable

    attr_accessor :matches, :data

    def_delegators :@data, :method_missing, :respond_to_missing?

    def initialize(data)
      @data = Hashie::Mash.new data
    end

    def participation_id
      @data['participation_id'].to_i
    end

    def comment_id
      @data['comment_id'].to_i
    end

    def text
      comment.content
    end

    def participation
      participation_id
    end

    def channel
      participation_id
    end

    def user
      # SlackAPI::User.find(id: @data['user'])
    end

    def ts
      # Time.at(@data['ts'].to_f)
    end

    def reply(text, options = {})
      options[:text] = text
      options[:channel] = channel
      Messenger.new(options).message
    end

    def bot_message?
      @data['subtype'] && @data['subtype'] == 'bot_message'
    end

    private

    def comment
      @comment ||= Remoppy::Remotty::Api::Comment.find(participations_id: participation_id, comment_id: comment_id)
    end
  end
end
