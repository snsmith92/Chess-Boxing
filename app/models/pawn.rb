class Pawn < Piece
  scope :piece, -> {where(type: 'Pawn')}

  def valid_move?(position_x, position_y)
    x_current = self.position_x
    y_current = self.position_y
    x_destination = position_x
    y_destination = position_y

    return false if outside_board?(x_destination, y_destination)

    if moves == 0
      return false if (y_destination - y_current).abs > 2
      true

    elsif moves > 0
      return false if (y_destination - y_current).abs != 1
      true

    else
      true
    end
    else
      return true
  end
end
