class Rook < Piece
  scope :piece, -> {where(type: 'Rook')}

  def valid_move?(position_x, position_y)
    self.position_x = current_x
    self.position_y = current_y
    position_x = x_destination
    position_y = y_destination

    if current_x == x_destination && is_obstructed_vertically? == false # vertical move
      return true
    elsif current_y == y_destination & is_obstructed_horizontally? == false # horizontal move
      return true 
    else 
      return false
    end 
  end 
end