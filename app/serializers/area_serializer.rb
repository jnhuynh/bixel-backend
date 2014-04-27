class AreaSerializer < ActiveModel::Serializer
  embed :ids, :include => true

  attributes :id, :name
  has_many :players
end
