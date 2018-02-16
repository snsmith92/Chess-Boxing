class Piece < ApplicationRecord
  belongs_to :game
  delegate :king, :queen, :bishop, :knight, :rook, :pawn, to: :pieces

  #needs models that inherit from piece called pawn, rook, knight, bishop, queen, king



# 1. Determine if any given square with (x,y) coordinates is currently occupied
  def is_occupied?(x,y)
    pieces.find_by(x: x, y: y).each do |piece|
      if piece.x == x && piece.y == y
        return true
      else
        return false
      end
    end
  end


  # 2. Model method is_obstructed for piece.rb
  def is_obstructed?(piece_destination)
    # 2a. location array [x, y] separated into individual variables
    x_current = piece[0]
    y_current = piece[1]
    x_destination = piece_destination[0]
    y_destination = piece_destination[1]

    if x_current == x_destination
        is_obstructed_vertically(piece_destination)
      elsif y_current == y_destination
        is_obstructed_horizontally(piece_destination)
      elsif 
        (y_destination - y_current)/(x_destination - x_current) == 1 ||(y_destination - y_current)/(x_destination - x_current) == -1
        is_obstructed_diagonally(piece_destination)
      else
        flash[:notice] "This move is not possible."
    end
  end


  # 3. See if there is a vertical obstruction
  def is_obstructed_vertically(piece_destination)
    x_current = piece[0]
    y_current = piece[1]
    y_destination = piece_destination[1]

    if y_current < y_destination
      (y_current+1).upto(y_destination-1) do |y|
        return true if is_occupied?(x_current, y) == true
      end
    else (y_current-1).downto(y_destination+1) do |y|
        return true if is_occupied?(x_current, y) == true
      end
    end
  end 

  # 4. See if there is a horizontal obstruction
  def is_obstructed_horizontally(piece_destination)
    x_current = piece[0]
    y_current = piece[1]
    x_destination = piece_destination[0]

    if x_current < x_destination
      (x_current+1).upto(x_destination-1) do |x|
        return true if is_occupied?(x, y_current) == true
      end 
    else (x_current-1).downto(x_destination+1) do |x|
        return true if is_occupied?(x, y_current) == true
      end 
    end
  end 

  # 5. See if there is a vertical obstruction
  def is_obstructed_diagonally(piece_destination)
    x_current = piece_location[0]
    y_current = piece_location[1]
    x_destination = piece_destination[0]
    y_destination = piece_destination[1]

    if x_current < x_destination && y_current < y_destination # up-right diagonal
      while x_current < x_destination && y_current < y_destination do |x, y|
        return true if is_occupied?(x += 1)(y += 1) == true
        end 
      end 
    elsif x_current > x_destination && y_current < y_destination # up-left diagonal
      while x_current > x_destination && y_current < y_destination do |x, y|
        return true if is_occupied?(x -= 1)(y += 1) == true
        end
      end 
    elsif x_current < x_destination && y_current > y_destination # down-right diagonal
      while x_current > x_destination && y_current < y_destination do |x, y|
        return true if is_occupied?(x += 1)(y -= 1) == true
        end 
      end 
    else
      while x_current > x_destination && y_current < y_destination do |x, y|
        return true if is_occupied?(x -= 1)(y -= 1) == true
        end 
      end 
    end 
  end 

  def move_to!(x_new, y_new)
    x_current = piece.position_x
    y_current = piece.position_y
    # 1. Check to see if there is a piece in the location the piece is moving to
    if is_occupied(x_new, y_new) == true 
      if piece(x_new, y_new).owner == piece(x_current, y_current).owner
        flash[:notice] "This space is occupied by your own piece"
      else

      end
    end
    # 2. If there is a piece at this location and it's the opposite color, remove that piece from the board
    # 3. If there is a piece at that location of the same color, the move should fail; do nothing
    # 4. Call update attributes on the piece and change its x/y position
  end

end
