class Pawn < Piece
  scope :piece, -> {where(type: 'Pawn')}

  def valid_move?(position_x, position_y)
    piece.position_x = x_current
    piece.position_y = y_current
    position_x = x_destination
    position_y = y_destination

    if outside_board?
      return false

end
