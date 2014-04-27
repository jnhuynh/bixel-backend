class Player < ActiveRecord::Base
  has_one :sprite_sheet
  belongs_to :area
end
