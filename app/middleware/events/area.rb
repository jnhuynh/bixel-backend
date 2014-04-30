require File.expand_path("../../../models/area", __FILE__)
require File.expand_path("../../../models/player", __FILE__)
require File.expand_path("../../../serializers/area_serializer", __FILE__)

module Events
  class Area
    class << self
      def index
        puts "Events::Area::index"

        response_payload = {}

        areas = ::Area.all

        player_ids = areas.map do |area|
          area.players.map(&:id)
        end.flatten.uniq.compact

        players = ::Player.where("id in (?)", player_ids)

        response_payload[:data]         = { }
        response_payload[:data][:areas] = ActiveModel::ArraySerializer
          .new(areas, :each_serializer => AreaSerializer).to_json

        # We must explicitly add the players property because ArraySerializer
        # does not side load association.
        response_payload[:data][:players] = ActiveModel::ArraySerializer
          .new(players, :each_serializer => PlayerSerializer).to_json

        response_payload
      end

      def player_enter(request_payload)
        puts "Events::Area::player_enter"

        area_id = request_payload["area"]["id"]

        response_payload = {}

        if area_id
          area = ::Area.where(:id => area_id).first

          if area
            player_ids = request_payload["area"]["players"]

            player_ids.each do |player_id|
              player = ::Player.where(:id => player_id).first

              area.players << player if player
            end

            area.save()

            response_payload[:data] = AreaSerializer.new(area).to_json
          else
            response_payload[:error] = "Events::Area::player_enter could not find area with id: #{id}"
          end
        else
          response_payload[:error] = "Events::Area::show requires an \"id\" property"
        end

        response_payload
      end

      def player_exit(data)
        puts "player_exit"
      end

      def player_move(data)
        puts "player_move"
      end
    end
  end
end

