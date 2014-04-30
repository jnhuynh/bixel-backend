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
    end
  end
end

