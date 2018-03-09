class AddOwnerOpponentToGames < ActiveRecord::Migration[5.0]
  def change
    # remove_column :games, :white_player
    # remove_column :games, :black_player
    add_column :games, :owner_id, :integer
    add_column :games, :opponent_id, :integer
  end
end
