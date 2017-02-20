module Remoppy
  module Listener
    module Validatable
      include Remoppy::Debuggable

      attr_accessor :pattern

      def valid?(event)
        target = event.send(target_element)
        unless target
          Debug.log 'Target is nil'
          return false
        end

        event.matches = target.match pattern

        unless event.matches
          Debug.log "Target is not match pattern(#{pattern})"
          return false
        end

        true
      end
    end
  end
end
