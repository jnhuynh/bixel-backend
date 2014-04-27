class CreateSpriteSheets < ActiveRecord::Migration
  def change
    create_table :sprite_sheets do |t|
      t.integer(:current_frame, :default => 0)

      t.string(:name, :null => false)
      t.string(:src, :null => false)

      t.integer(:player_id)

      t.timestamps
    end
  end
end
