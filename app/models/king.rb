class King < Piece
  scope :piece, -> {where(type: 'King')}

  def valid_move?(position_x, position_y)
    self.position_x.to_i = x_current
    self.position_y.to_i = y_current
    position_x = x_destination
    position_y = y_destination

    # If piece_destination is not within the board -- not allowed
    if outside_board?
      return false

    # If piece_destination coordinates is more than +1 or less than -1
    elsif (x_current - x_destination).abs > 1 || (y_current - y_destination).abs > 1 
      # flash[:alert] = "This move is not allowed!"
      return false

    # If piece_destination is occupied by a piece of the same user -- not allowed
    elsif is_occupied?(position_x, position_y) && piece.user == current_user
      # flash[:alert] = "You cannot capture your own piece!"
      return false
    else
      return true
    end
  end
end