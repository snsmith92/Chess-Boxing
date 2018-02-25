class Queen < Piece
  scope :piece, -> {where(type: 'Queen')}
  
  def valid_move?(position_x, position_y)
    Rook.new(position_x,position_y).valid_move? or Bishop.new(position_x, position_y)

    if outside_board?(position_x, position_y)
      return false

    elsif is_occupied?(piece_destination) && piece.user == current_user
      flash[:alert] = "You cannot capture your own piece!"
      return false
      
    else
      return true
    end
  end
end