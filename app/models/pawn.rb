class Pawn < Piece
  scope :piece, -> {where(type: 'Pawn')}

  def valid_move?(x_destination, y_destination)
    x_current = self.position_x.to_i
    y_current = self.position_y.to_i
  
    #pawn capture logic
    if x_destination != x_current
      piece = Piece.find_by(game_id: self.game_id, position_x: x_destination, position_y: y_destination)
      if self.color = "white" && piece.color == "black"
        return true if piece.position_y == y_current+1 && piece.position_x == x_current-1
        return true if piece.position_y == y_current+1 && piece.position_x == x_current+1
      elsif self.color = "black" && piece.color == "white"
        return true if piece.position_y == y_current-1 && piece.position_x == x_current-1
        return true if piece.position_y == y_current-1 && piece.position_x == x_current+1
      end
    end

    #normal pawn move
    return false if outside_board?(x_destination, y_destination) || is_obstructed?(x_destination, y_destination)

    if self.moves == 0
      return false if (y_destination - y_current).abs > 2
      true

    elsif self.moves > 0
      return false if (y_destination - y_current).abs != 1
      true

    else
      true
    end
  end
end
