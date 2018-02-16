class King < Piece
  scope :piece, -> {where(type: 'King')}

  def valid_move?(piece_destination)
    piece[0] = x_current
    piece[1] = y_current
    piece_destination[0] = x_destination
    piece_destination[1] = y_destination

    # If piece_destination is not within the board -- not allowed
    if x_destination < 1 || x_destination > 8 || y_destination < 1 || y_destination > 8
      return false

    # If piece_destination coordinates is more than +1 or less than -1
    elsif (x_current - x_destination).abs > 1 || (y_current - y_destination).abs > 1 
      flash[:alert] = "This move is not allowed!"
      return false

    # If piece_destination is occupied by a piece of the same user -- not allowed
    elsif is_occupied?(piece_destination) && piece.user == current_user
      flash[:alert] = "You cannot capture your own piece!"
      return false
    
    else
      return true
    end
  end
end