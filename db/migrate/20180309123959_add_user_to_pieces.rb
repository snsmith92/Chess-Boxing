class AddUserToPieces < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :user, :integer
  end
end
