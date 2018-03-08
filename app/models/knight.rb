class Knight < Piece
  scope :piece, -> {where(type: 'Knight')}

  def valid_move?(new_x, new_y)
    return false if outside_board?(new_x, new_y)
    #does not matter if knight is obstructed on its way to its new space; it can jump over other pieces

    if (self.position_x - new_x).abs + (self.position_y - new_y).abs == 3 &&
      (self.position_x - new_x).abs != 0 &&
      (self.position_y - new_y).abs != 0
      return true
    end 

end 