module Remoppy
  class Messenger
    class MissingParticipationException < StandardError; end

    def initialize(options = {})
      opt = options.dup
      @destination = opt.delete(:participation)
      @options = opt
    end

    def message
      dest_id = @options.delete(:participation_id) || participation_id(@options.delete(:participation))
      raise MissingParticipationException unless dest_id

      options = merge_params(@options)

      Remoppy::Remotty::Api::Comment.create(participations_id: dest_id, comment: {content: options[:text], all: options.fetch(:all, false)})
    end

    private

    def participation_id(participation_name)
      room = Remoppy::Remotty::Api::Room.rooms
      room.participations.find {|p| p.name == participation_name }&.id
    end

    def config
      Remoppy.configuration
    end

    def merge_params(options)
      default = config.send_params
      default.merge options
    end
  end
end
