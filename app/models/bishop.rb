class Bishop < Piece
  scope :piece, -> {where(type: 'Bishop')}

  def valid_move?(position_x, position_y)
    x_current = self.position_x
    y_current = self.position_y
    x_destination = position_x
    y_destination = position_y

    if outside_board?(position_x, position_y) || is_obstructed?(position_x, position_y)
      return false

    elsif
      ((y_current - y_destination) / (x_current - x_destination)).abs != 1
      flash[:alert] = "This move is not allowed!"
      return false

    elsif is_occupied?(x_destination, y_destination) && piece.user == current_user
      flash[:alert] = "You cannot capture your own piece!"
      return false

    else
      return true
    end
  end
end
