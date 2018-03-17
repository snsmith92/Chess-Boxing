class AddTurnsToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :turn_id, :integer
  end
end
