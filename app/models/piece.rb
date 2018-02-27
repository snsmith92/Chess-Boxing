class Piece < ApplicationRecord
  belongs_to :game
  delegate :king, :queen, :bishop, :knight, :rook, :pawn, to: :pieces

  def outside_board?(position_x, position_y)
    position_x < 0 || position_x > 7 || position_y < 0 || position_y > 7
  end

  def show_image
    "#{type.downcase}-#{color.downcase}.png"
  end

  def is_occupied?(position_x, position_y)
    pieces.find_by(position_x: position_x, position_y: position_y).each do |piece|
      if piece.position_x == position_x && piece.position_y == position_y
        return true
      else
        return false
      end
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
    x_current = piece.position_x
    y_current = piece.position_y
    y_destination = position_y

    if y_current < y_destination
      (y_current+1).upto(y_destination-1) do |y|
        return true if is_occupied?(x_current, y) == true
      end
    else (y_current-1).downto(y_destination+1) do |y|
        return true if is_occupied?(x_current, y) == true
      end
    end
  end

  def is_obstructed_horizontally(position_x, position_y)
    x_current = piece.position_x
    y_current = piece.position_y
    x_destination = position_x

    if x_current < x_destination
      (x_current+1).upto(x_destination-1) do |x|
        return true if is_occupied?(x, y_current) == true
      end
    else (x_current-1).downto(x_destination+1) do |x|
        return true if is_occupied?(x, y_current) == true
      end
    end
  end

  def is_obstructed_diagonally(position_x, position_y)
    x_current = piece.position_x
    y_current = piece.position_y
    x_destination = position_x
    y_destination = position_y
  #
  #   if x_current < x_destination && y_current < y_destination # up-right diagonal
  #     while x_current < x_destination && y_current < y_destination do |x, y|
  #       return true if is_occupied?((x += 1),(y += 1))
  #     end
  #   elsif x_current > x_destination && y_current < y_destination # up-left diagonal
  #     while x_current > x_destination && y_current < y_destination do |x, y|
  #       return true if is_occupied?((x -= 1),(y += 1))
  #     end
  #   elsif x_current < x_destination && y_current > y_destination # down-right diagonal
  #     while x_current > x_destination && y_current < y_destination do |x, y|
  #       return true if is_occupied?((x += 1),(y -= 1))
  #     end
  #   else
  #     while x_current > x_destination && y_current < y_destination do |x, y|
  #       return true if is_occupied?((x -= 1),(y -= 1))
  #     end
  #   end
   end

  def move_to!(x_new, y_new)
    x_current = self.position_x
    y_current = self.position_y
    x_destination = position_x
    y_destination = position_y

    #moving to an empty space, move is valid
    if ! is_occupied?(x_destination, y_destination) && valid_move?(x_destination, y_destination)
      piece.update_attributes(:position_x => x_destination, :position_y => y_destination)
    #moving to an occupied space, move is valid
    #the valid_move? method covers the color of the piece
    elsif is_occupied?(x_destination, y_destination) && valid_move?(x_destination, y_destination)
      game.pieces.where(position_x = x_destination, position_y = y_destination).delete
      piece.update_attributes(:position_x => x_destination, :position_y => y_destination)
    end
  end
end
