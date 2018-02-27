class Pawn < Piece
  scope :piece, -> {where(type: 'Pawn')}

  move_count = 0
  def count_moves
    if #piece makes a move
      move_count += 1
    end
  end

  def valid_move?(position_x, position_y)
    piece.position_x = x_current
    piece.position_y = y_current
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

  elsif

  end
end
