require File.expand_path("../../../models/player", __FILE__)
require File.expand_path("../../../models/sprite_sheet", __FILE__)
require File.expand_path("../../../serializers/player_serializer", __FILE__)

module Events
  class Player
    class << self
      def create(request_payload)
        name = request_payload["player"]["name"]

        puts "Events::Player::create"
        response_payload = {}

        if name
          base_body  = ::SpriteSheet.where(:name => "Base Body").first
          new_player = ::Player.new(:name => name, :sprite_sheet => base_body)

          if new_player.valid?
            new_player.save

            response_payload[:data] = PlayerSerializer.new(new_player).to_json
          end
        else
          response_payload[:error] = "Events::Player::create requires a \"name\" property"
        end

        response_payload
      end

      def show(request_payload)
        id = request_payload["player"]["id"]

        puts "Events::Player::show"
        response_payload = {}

        if id
          player = ::Player.where(:id => id).first

          if player
            response_payload[:data] = PlayerSerializer.new(player).to_json
          else
            response_payload[:error] = "Events::Player::show could not find player with id: #{id}"
          end
        else
          response_payload[:error] = "Events::Player::show requires an \"id\" property"
        end

        response_payload
      end

      def move(request_payload)
        id = request_payload["player"]["id"]

        puts "Events::Player::move"
        response_payload = {}

        if id
          player = ::Player.where(:id => id).first

          if player
            player.x = request_payload["player"]["x"]
            player.y = request_payload["player"]["y"]

            player.save

            response_payload[:data] = PlayerSerializer.new(player).to_json
          else
            response_payload[:error] = "Events::Player::move could not find player with id: #{id}"
          end
        else
          response_payload[:error] = "Events::Player::move requires an \"id\" property"
        end

        response_payload
      end
    end
  end
end

