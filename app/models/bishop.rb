class Bishop < Piece
  scope :piece, -> {where(type: 'Bishop')}

  def valid_move?(position_x, position_y)
    piece.position_x = x_current
    piece.position_y = y_current
    position_x = x_destination
    position_y = y_destination

    if outside_board?(position_x, position_y)
      return false

    elsif
      ((y_current - y_destination) / (x_current - x_destination)).abs != 1
      flash[:alert] = "This move is not allowed!"
      return false

    elsif is_occupied?(piece_destination) && piece.user == current_user
      flash[:alert] = "You cannot capture your own piece!"
      return false

    else
      return true
    end
  end
end
