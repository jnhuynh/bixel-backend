class CreateSpriteSheets < ActiveRecord::Migration
  def change
    create_table :sprite_sheets do |t|
      t.integer :current_frame
      t.string :name
      t.string :src
      t.integer :player_id

      t.timestamps
    end
  end
end
