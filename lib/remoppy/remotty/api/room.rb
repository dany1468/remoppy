module Remoppy
  module Remotty
    class Api
      class Room < Flexirest::Base
        has_many :participations, Participation
        get :rooms, '/rooms'

      end
    end
  end
end
