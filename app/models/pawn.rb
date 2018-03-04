class Pawn < Piece
  scope :piece, -> {where(type: 'Pawn')}

  def valid_move?(position_x, position_y)
    piece.position_x.to_i = x_current
    piece.position_y.to_i = y_current
    position_x = x_destination
    position_y = y_destination

    if outside_board?
      return false

    elsif move_count == 0
       if (y_destination - y_current).abs > 2
        flash[:alert] = "This move is not allowed!"
        return false
        end

    elsif move_count > 0
      if (y_destination - y_current).abs > 1
        flash[:alert] = "This move is not allowed!"
        return false
      end

    elsif is_occupied?(x_current+1, y_current+1)
      flash[:alert] = "This move is not allowed!"
    end
    else
      return true
  end
end
