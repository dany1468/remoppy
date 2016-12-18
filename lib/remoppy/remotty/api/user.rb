module Remoppy
  module Remotty
    class Api
      class User < Flexirest::Base
        get :me, '/me'
      end
    end
  end
end
