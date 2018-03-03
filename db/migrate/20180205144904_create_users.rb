class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    change_table :users do |t|
      t.integer :game_id
      t.boolean :victory
      t.boolean :turn
    end
    add_index :users, :game_id
  end
end
