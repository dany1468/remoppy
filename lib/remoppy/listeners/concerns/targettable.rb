module Remoppy
  module Listener
    module Targettable
      include Remoppy::Debuggable

      def target?(event)
        target.valid? event
      end

      def target
        @target ||= Target.new
      end

      private

      class Target
        def valid?(event)
          return true if participation.blank?

          result = []

          result << false unless validation(:participation, event)

          result.blank?
        end

        def validation(target, event)
          return true if send(target).compact.blank?

          unless send(target).include?(event.send(target))
            Debug.log "Message from restrict #{target}(expect: #{target_names(target)})"
            return false
          end

          true
        end

        def participation=(participation_names)
          @participation = to_participation(Array.wrap(participation_names))
        end

        def participation
          @participation ||= []
        end

        def to_participation(participation_names)
          room = Remoppy::Remotty::Api::Room.rooms
          room.participations.select {|p| p.name.in?(participation_names) }.map(&:id)
        end

        def target_names(target)
          send(target).join(',')
        end
      end
    end
  end
end
