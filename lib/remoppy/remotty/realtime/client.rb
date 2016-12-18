require 'socket.io-client-simple'
require 'eventmachine'

module Remoppy
  module Remotty
    module Realtime
      class Client
        attr_reader :url, :room_id, :participation_id

        def initialize(url, room_id, participation_id)
          @url = url
          @room_id = room_id
          @participation_id = participation_id
          @callbacks ||= {}
        end

        def on(type, &block)
          @callbacks[type] ||= []
          @callbacks[type] << block
        end

        def start
          block = ->(type) { @callbacks[type] }
          join_block = -> { {participation_id: participation_id, room_id: room_id, select_id: participation_id} }

          EM.run do
            socket = SocketIO::Client::Simple.connect url

            socket.on :connect do
              socket.emit :join, join_block.call

              block.call(:hello).try(:each) do |callback|
                callback.call
              end
            end

            socket.on :disconnect do
              block.call(:goodnight).try(:each) do |callback|
                callback.call
              end
            end

            socket.on :join do
              block.call(:join).try(:each) do |callback|
                callback.call
              end
            end

            socket.on :error do |err|
              p err
            end

            socket.on 'message' do |data|
              if data.key?('comment_id')
                block.call(:comment).try(:each) do |callback|
                  callback.call data
                end
              elsif data.key?('message_id')
                block.call(:message).try(:each) do |callback|
                  callback.call data
                end
              end
            end
          end
        end
      end
    end
  end
end
