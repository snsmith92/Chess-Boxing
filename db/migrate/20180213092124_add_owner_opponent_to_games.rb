class AddOwnerOpponentToGames < ActiveRecord::Migration[5.0]
  def change
    remove_column :games, :white_player
    remove_column :games, :black_player
    add_column :games, :owner, :integer
    add_column :games, :opponent, :integer
  end
end
