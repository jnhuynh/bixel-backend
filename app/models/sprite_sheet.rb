# == Schema Information
#
# Table name: sprite_sheets
#
#  id            :integer          not null, primary key
#  current_frame :integer          default(0)
#  name          :string(255)      not null
#  src           :string(255)      not null
#  player_id     :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class SpriteSheet < ActiveRecord::Base
  belongs_to :player
end
