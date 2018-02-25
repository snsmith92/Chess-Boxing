class Knight < Piece
  scope :piece, -> {where(type: 'Knight')}

  def valid_move?(new_x, new_y)
    return false if outside_board?(new_x, new_y)
    #does not matter if knight is obstructed on its way to its new space; it can jump over other pieces
    #I know this code is about as dry as the ocean, so refactoring suggestions are appreciated! :)
    
    #knight can move up 2, left or right 1
    return true if self.position_x + 1 == new_x && self.position_y + 2 == new_y
    return true if self.position_x - 1 == new_x && self.position_y + 2 == new_y
    #knight can move down 2, left or right 1
    return true if self.position_x + 1 == new_x && self.position_y - 2 == new_y
    return true if self.position_x - 1 == new_x && self.position_y - 2 == new_y
    #knight can move right 2, up or down 1
    return true if self.position_x + 2 == new_x && self.position_y + 1 == new_y
    return true if self.position_x + 2 == new_x && self.position_y - 1 == new_y
    #knight can move left 2, up or down 1
    return true if self.position_x - 2 == new_x && self.position_y + 1 == new_y
    return true if self.position_x - 2 == new_x && self.position_y - 1 == new_y
  end

end 