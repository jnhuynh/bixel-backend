class SpriteSheetSerializer < ActiveModel::Serializer
  attributes :id, :name, :src, :current_frame

  has_one :player, :key => "player"
end
