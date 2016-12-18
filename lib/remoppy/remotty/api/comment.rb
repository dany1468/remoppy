module Remoppy
  module Remotty
    class Api
      class Comment < Flexirest::Base
        get :all, '/rooms/participations/:participations_id/comments'
        get :find, '/rooms/participations/:participations_id/comments/:comment_id'
        post :create, '/rooms/participations/:participations_id/comments'
      end
    end
  end
end
