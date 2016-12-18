module Remoppy
  module Remotty
    class Api
      class Participation < Flexirest::Base
        def comments
          Comment.all(participations_id: self.id)
        end

        def post_comment(content)
          Comment.create(participations_id: self.id, comment: {content: content})
        end
      end
    end
  end
end
