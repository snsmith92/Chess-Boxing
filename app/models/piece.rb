class Piece < ApplicationRecord
  belongs_to :game
  delegate :king, :queen, :bishop, :knight, :rook, :pawn, to: :pieces

  def outside_board?(position_x, position_y)
    position_x < 0 || position_x > 7 || position_y < 0 || position_y > 7
  end

  def valid_move?(position_x, position_y)
    if outside_board?(self.position_x.to_i, self.position_y.to_i)
      return false
    end
  end

  def show_image
    "#{type.downcase}-#{color.downcase}.png"
  end

  def is_occupied?(destination_x, destination_y)
    if Piece.find_by(position_x: destination_x, position_y: destination_y) != nil
      return true
    end
  end


  def is_obstructed?(position_x, position_y)
    x_current = piece.position_x
    y_current = piece.position_y
    x_destination = position_x
    y_destination = position_y

    if x_current == x_destination
      is_obstructed_vertically(position_x, position_y)
    elsif y_current == y_destination
      is_obstructed_horizontally(position_x, position_y)
    elsif (y_destination - y_current)/(x_destination - x_current) == 1 ||(y_destination - y_current)/(x_destination - x_current) == -1
      is_obstructed_diagonally(position_x, position_y)
    else
        # flash[:notice] "This move is not possible."
    end
  end


  def is_obstructed_vertically(position_x, position_y)
    x_current = self.position_x.to_i
    y_current = self.position_y.to_i
    y_destination = position_y.to_i

    if y_current < y_destination
      (y_current+1).upto(y_destination-1) do |y|
        return true if is_occupied?(x_current, y) == true
      end
    else (y_current-1).downto(y_destination+1) do |y|
        return true if is_occupied?(x_current, y) == true
      end
    end
  end

  def is_obstructed_horizontally(destination_x, destination_y)
    x_current = self.position_x.to_i
    y_current = self.position_y.to_i
    x_destination = destination_x

    if x_current < x_destination
      (x_current + 1).upto(x_destination - 1).each do |x|
        return true if is_occupied?(x, y_current)
      end
    elsif x_current > x_destination
       (x_current - 1).downto(x_destination + 1).each do |x|
        return true if is_occupied?(x, y_current)
      end
    end
  end

  def is_obstructed_diagonally(position_x, position_y)
    x_current = self.position_x.to_i
    y_current = self.position_y.to_i
    x_destination = position_x
    y_destination = position_y


    if x_current < x_destination && y_current < y_destination # up-right diagonal
      while x_current < x_destination && y_current < y_destination do
        return true if is_occupied?((x_current += 1),(y_current += 1))
      end
    elsif x_current > x_destination && y_current < y_destination # up-left diagonal
      while x_current > x_destination && y_current < y_destination do
        return true if is_occupied?((x_current -= 1),(y_current += 1))
      end
    elsif x_current < x_destination && y_current > y_destination # down-right diagonal
      while x_current > x_destination && y_current < y_destination do
        return true if is_occupied?((x_current += 1),(y_current -= 1))
      end
    else
      while x_current > x_destination && y_current < y_destination do
        return true if is_occupied?((x_current -= 1),(y_current -= 1))
      end
    end
   end

  def move_count
    moves = 0
    moves += 1
  end

  def move_to!(position_x, position_y)
    x_current = self.position_x.to_i
    y_current = self.position_y.to_i
    x_destination = position_x
    y_destination = position_y
    #moving to an empty space, move is valid
    if (is_occupied?(x_destination, y_destination) == false)
      # && valid_move?(x_destination, y_destination)
      piece.update_attributes(:position_x => x_destination, :position_y => y_destination)
      piece.move_count
    #moving to an occupied space, move is valid
    #the valid_move? method covers the color of the piece
    elsif is_occupied?(x_destination, y_destination) && valid_move?(x_destination, y_destination)
      game.pieces.where(position_x = x_destination, position_y = y_destination).delete
      piece.update_attributes(:position_x => x_destination, :position_y => y_destination)
    end
  end

  def valid_move_vertical?(position_x, position_y)
    !is_obstructed_vertically(position_x, position_y)
  end 

  def valid_move_horizontal?(position_x, position_y)
    !is_obstructed_horizontally(position_x, position_y)
  end 
end
