# == Schema Information
#
# Table name: players
#
#  id         :integer          not null, primary key
#  x          :decimal(, )      default(0.0)
#  y          :decimal(, )      default(0.0)
#  name       :string(255)
#  area_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Player < ActiveRecord::Base
  has_one :sprite_sheet
  belongs_to :area
end
