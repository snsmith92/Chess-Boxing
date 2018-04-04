class Piece < ApplicationRecord
  # attr_accessor :position_x, :position_y
  belongs_to :game
  belongs_to :user
  delegate :king, :queen, :bishop, :knight, :rook, :pawn, to: :pieces
  

  def outside_board?(position_x, position_y)
    position_x < 0 || position_x > 7 || position_y < 0 || position_y > 7
  end

  def valid_move?(position_x, position_y)
    if outside_board?(self.position_x, self.position_y)
      return false
    elsif is_in_self_check?
       return false
    else 
      return true
    end
  end

  def show_image
    "#{self.type.downcase}-#{self.color.downcase}.png"
  end

  def is_occupied?(destination_x, destination_y)
    piece = Piece.find_by(position_x: destination_x, position_y: destination_y)
    if piece.nil?
      return false
    else
      true
    end
  end


  def is_obstructed?(position_x, position_y)
    x_current = self.position_x
    y_current = self.position_y
    x_destination = position_x
    y_destination = position_y

    if x_current == x_destination
      is_obstructed_vertically(position_x, position_y)
    elsif y_current == y_destination
      is_obstructed_horizontally(position_x, position_y)
    elsif (y_destination - y_current)/(x_destination - x_current).abs == 1
      is_obstructed_diagonally(position_x, position_y)
    else
      false
    end
  end


  def is_obstructed_vertically(position_x, position_y)

    x_current = self.position_x
    y_current = self.position_y
    y_destination = position_y

    if y_current < y_destination #up
      (y_current+1).upto(y_destination-1) do |y|
        return true if is_occupied?(x_current, y)
      end
      false
    else 
      (y_current-1).downto(y_destination+1) do |y|
        return true if is_occupied?(x_current, y)
      end
      false
    end
  end

  def is_obstructed_horizontally(destination_x, destination_y)
    x_current = self.position_x
    y_current = self.position_y
    x_destination = destination_x

    if x_current < x_destination
      (x_current + 1).upto(x_destination - 1).each do |x|
        return true if game.is_occupied?(x, y_current)
      end
      false
    elsif x_current > x_destination
      (x_current - 1).downto(x_destination + 1).each do |x|
        return is_occupied?(x, y_current)
      end
      false
    end
  end

  def is_obstructed_diagonally(position_x, position_y)
    x_current = self.position_x
    y_current = self.position_y
    x_destination = position_x
    y_destination = position_y

    if x_current < x_destination && y_current < y_destination # up-right diagonal
      while x_current < x_destination && y_current < y_destination do
        return true if game.is_occupied?((x_current += 1),(y_current += 1))
      end
      false
    elsif x_current > x_destination && y_current < y_destination # up-left diagonal
      while x_current > x_destination && y_current < y_destination do
        return true if game.is_occupied?((x_current -= 1),(y_current += 1))
      end
      false
    elsif x_current < x_destination && y_current > y_destination # down-right diagonal
      while x_current > x_destination && y_current < y_destination do
        return true if game.is_occupied?((x_current += 1),(y_current -= 1))
      end
      false
    else #down-left diagonal
      while x_current > x_destination && y_current < y_destination do
        return true if game.is_occupied?((x_current -= 1),(y_current -= 1))
      end
      false
    end
   end

  def move_to!(position_x, position_y)
    x_current = self.position_x.to_i
    y_current = self.position_y.to_i
    x_destination = position_x
    y_destination = position_y
    move_count = self.moves + 1

    if self.valid_move?(x_destination, y_destination) == false
      return false
    elsif self.game.is_occupied?(x_destination, y_destination) == false
      update_attributes(:position_x => x_destination, :position_y => y_destination, :moves => move_count)
      self.game.update_turn!
    else self.game.is_occupied?(x_destination, y_destination)
      game.pieces.where(position_x = x_destination, position_y = y_destination).update_attributes(:captured => true)
      update_attributes(:position_x => x_destination, :position_y => y_destination, :moves => move_count)
      self.game.update_turn!
    end 
  end

  def valid_move_vertical?(position_x, position_y)
    !is_obstructed_vertically(position_x, position_y)
  end

  def valid_move_horizontal?(position_x, position_y)
    !is_obstructed_horizontally(position_x, position_y)
  end 

end
