class Pawn < Piece
  scope :piece, -> {where(type: 'Pawn')}

  def valid_move?(position_x, position_y)
    x_current = self.position_x
    y_current = self.position_y
    x_destination = position_x
    y_destination = position_y

    return false if outside_board?(x_destination, y_destination)

    if self.moves == 0
      puts "MOVES == 0"
      return false if (y_destination - y_current).abs > 2
      true
      #   flash[:alert] = "This move is not allowed!"
      #   return false

    elsif self.moves > 0
      puts "MOVES > 0"
      return false if (y_destination - y_current).abs != 1
      true
      #   flash[:alert] = "This move is not allowed!"
      #   return false
      # else
      #   return true
      # end

    # elsif is_occupied?(x_current+1, y_current+1)
    #   flash[:alert] = "This move is not allowed!"
    # end
    else
      return true
    end
  end
end
