class RenameOwnerOpponentInGame < ActiveRecord::Migration[5.0]
  def change
    rename_column :games, :owner, :owner_id
    rename_column :games, :opponent, :opponent_id
  end
end
