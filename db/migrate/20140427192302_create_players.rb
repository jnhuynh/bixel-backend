class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.decimal :x
      t.decimal :y
      t.string :name
      t.integer :area_id

      t.timestamps
    end
  end
end
