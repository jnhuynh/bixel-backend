require File.expand_path("../../../models/area", __FILE__)
require File.expand_path("../../../serializers/area_serializer", __FILE__)

module Events
  class Area
    class << self
      def index
        puts "Events::Area::index"
        response_payload = {}

        areas = ::Area.all
        response_payload[:data] = ActiveModel::ArraySerializer
          .new(areas, each_serializer: AreaSerializer).to_json

        response_payload
      end

      def player_enter(data)
        puts "player_enter"
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

