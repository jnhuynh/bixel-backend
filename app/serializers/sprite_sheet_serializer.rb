class SpriteSheetSerializer < ActiveModel::Serializer
  attributes :id, :name, :src, :current_frame
end
