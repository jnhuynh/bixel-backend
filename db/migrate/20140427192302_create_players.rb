class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.decimal(:x, :default => 0)
      t.decimal(:y, :default => 0)

      t.string(:name)

      t.integer(:area_id)

      t.timestamps
    end
  end
end
