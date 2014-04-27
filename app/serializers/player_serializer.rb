class PlayerSerializer < ActiveModel::Serializer
  embed :ids, :include => true

  attributes :id, :name, :x, :y
  has_one :spritesheet
end
