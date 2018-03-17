class Queen < Piece
  scope :piece, -> {where(type: 'Queen')}

    def valid_move?(position_x, position_y)
      current_x = self.position_x
      current_y = self.position_y
      x_destination = position_x
      y_destination = position_y

      if current_x == x_destination # vertical move
        valid_move_vertical?(position_x, position_y)
      elsif current_y == y_destination # horizontal move
        valid_move_horizontal?(position_x, position_y)
      elsif (y_destination - y_current)/(x_destination - x_current) == 1 ||(y_destination - y_current)/(x_destination - x_current) == -1
        valid_move_diagonal?(position_x,position_y)
      elsif outside_board?(position_x, position_y)
        return false
      elsif is_occupied?(piece_destination) && piece.user == current_user
        flash[:alert] = "You cannot capture your own piece!"
        return false
      else
        return true
      end
    end
  end
