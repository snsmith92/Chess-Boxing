class Rook < Piece
  scope :piece, -> {where(type: 'Rook')}

  def valid_move?(position_x, position_y)
    x_destination = position_x 
    y_destination = position_y

    if self.position_x.to_i == x_destination # vertical move
      valid_move_vertical?(position_x, position_y)
    elsif self.position_y.to_i == y_destination # horizontal move
      valid_move_horizontal?(position_x, position_y)
    else 
      return false
    end 
  end 
end