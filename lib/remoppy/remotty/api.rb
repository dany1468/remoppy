require_relative 'realtime/client'
require_relative 'api/comment'
require_relative 'api/participation'
require_relative 'api/room'
require_relative 'api/user'

Flexirest::Base.base_url = 'https://www.remotty.net/api/v1'
Flexirest::Base.before_request do |_name, request|
  # FIXME 結合が強いので token は Remotty 名前空間内で保持できるようにしておく
  request.headers['Authorization'] = "Bearer #{Remoppy.configuration.token}"
end

module Remoppy
  module Remotty
    class Api
      WEB_SOCKET_URL = 'https://websocket.remotty.net'.freeze

      def realtime
        bot_user = User.me
        Remoppy::Remotty::Realtime::Client.new(WEB_SOCKET_URL, bot_user.room_id, bot_user.participation_id)
      end
    end
  end
end
