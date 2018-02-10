class AddBlackPlayerToGameModel < ActiveRecord::Migration[5.0]
  def change
    change_table :games do |t|
      t.integer :white_player
      t.integer :black_player
    end
  end
end
