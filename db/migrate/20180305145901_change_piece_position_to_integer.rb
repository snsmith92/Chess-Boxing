class ChangePiecePositionToInteger < ActiveRecord::Migration[5.0]
  def change
    remove_column :pieces, :position_x
    remove_column :pieces, :position_y
    add_column :pieces, :position_x, :integer
    add_column :pieces, :position_y, :integer
  end
end
