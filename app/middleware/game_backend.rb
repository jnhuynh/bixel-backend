require "faye/websocket"
require "json"

require File.expand_path("../events/area", __FILE__)
require File.expand_path("../events/player", __FILE__)

class GameBackend
  # Needed to prevent Heroku Timeout
  KEEPALIVE_TIME = 15 # in seconds

  def initialize(app)
    @app     = app
    @clients = []
  end

  def call(env)
    # Create a new websocket if it is a websocket request.
    if Faye::WebSocket.websocket?(env)
      ws = Faye::WebSocket.new(env, nil, { ping: KEEPALIVE_TIME })

      ws.on :open do |event|
        p [:open, ws.object_id]
        @clients << ws
      end

      ws.on :message do |event|
        data       = JSON.parse(event.data)
        event_name = data["event_name"]

        puts "GameBackend Web Socket"
        puts "\t request payload: #{data}\n\n"

        payload = case event_name
                  when "area/index"
                    Events::Area.index
                  when "area/player_enter"
                    Events::Area.player_enter(data)
                  when "area/player_exit"
                    Events::Area.player_exit(data)
                  when "player/create"
                    Events::Player.create(data)
                  when "player/show"
                    Events::Player.show(data)
                  when "player/move"
                    Events::Player.move(data)
                  else
                    {}
                  end

        # uuid used by frontend for async resolve/reject
        payload[:uuid]       = data["uuid"]
        payload[:event_name] = event_name

        payload_string = payload.to_json
        puts "\tresponse payload: #{payload}\n\n"

        @clients.each do |client|
          client.send(payload_string)
        end
      end

      ws.on :close do |event|
        p [:close, ws.object_id, event.code, event.reason]
        @clients.delete(ws)
        ws = nil
      end

      # Return async Rack response
      ws.rack_response
    else
      @app.call(env)
    end
  end
end
