class Rook < Piece
  scope :piece, -> {where(type: 'Rook')}

  def valid_move?(position_x, position_y)
    self.position_x = current_x
    self.position_y = current_y
    position_x = x_destination
    position_y = y_destination

    if current_x == x_destination # vertical move
      valid_move_vertical?(position_x, position_y)
    elsif current_y == y_destination # horizontal move
      valid_move_horizontal?(position_x, position_y)
    else 
      return false
    end 
  end 
end