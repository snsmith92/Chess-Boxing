class Game < ApplicationRecord
  attr_accessor :owner_id, :opponent_id, :turn

  belongs_to :owner, class_name: 'User'
  belongs_to :opponent, class_name: 'User', optional: true
  has_many :pieces

  scope :available, -> { where(Game.arel_table[:owner_id].not_eq(0)).where(opponent = nil) }

  def populate_game!
    Rook.create(game_id: self.id, moves: 0, position_x: 0, position_y: 0, color: "white", captured: false, user: owner)
    Knight.create(game_id: self.id, moves: 0, position_x: 1, position_y: 0, color: "white", captured: false, user: owner)
    Bishop.create(game_id: self.id, moves: 0, position_x: 2, position_y: 0, color: "white", captured: false, user: owner)
    King.create(game_id: self.id, moves: 0, position_x: 3, position_y: 0, color: "white", captured: false, user: owner)
    Queen.create(game_id: self.id, moves: 0, position_x: 4, position_y: 0, color: "white", captured: false, user: owner)
    Bishop.create(game_id: self.id, moves: 0, position_x: 5, position_y: 0, color: "white", captured: false, user: owner)
    Knight.create(game_id: self.id, moves: 0, position_x: 6, position_y: 0, color: "white", captured: false, user: owner)
    Rook.create(game_id: self.id, moves: 0, position_x: 7, position_y: 0, color: "white", captured: false, user: owner)

    (0..7).each do |n|
      Pawn.create(game_id: self.id, moves: 0, position_x: n, position_y: 1, color: "white", captured: false, user: owner)
    end

    Rook.create(game_id: self.id, moves: 0, position_x: 0, position_y: 7, color: "black", captured: false, user: opponent)
    Knight.create(game_id: self.id, moves: 0, position_x: 1, position_y: 7, color: "black", captured: false, user: opponent)
    Bishop.create(game_id: self.id, moves: 0, position_x: 2, position_y: 7, color: "black", captured: false, user: opponent)
    King.create(game_id: self.id, moves: 0, position_x: 3, position_y: 7, color: "black", captured: false, user: opponent)
    Queen.create(game_id: self.id, moves: 0, position_x: 4, position_y: 7, color: "black", captured: false, user: opponent)
    Bishop.create(game_id: self.id, moves: 0, position_x: 5, position_y: 7, color: "black", captured: false, user: opponent)
    Knight.create(game_id: self.id, moves: 0, position_x: 6, position_y: 7, color: "black", captured: false, user: opponent)
    Rook.create(game_id: self.id, moves: 0, position_x: 7, position_y: 7, color: "black", captured: false, user: opponent)

    (0..7).each do |n|
      Pawn.create(game_id: self.id, moves: 0, position_x: n, position_y: 6, color: "black", captured: false, user: opponent)
    end
  end

  def in_check?(king)
    in_check_pieces = []
    if king.color == 'black'
      color = 'white' 
    else
      color = 'black'
    end 

    opponent_pieces = self.pieces.where(color: color, captured: false)
    opponent_pieces.each do |piece|
      if piece.valid_move?(king.position_x, king.position_y)
        return true
        in_check_pieces << piece
      end 
    end 
    return false
  end 

  def is_occupied?(destination_x, destination_y)
    Piece.find_by(game_id: self, position_x: destination_x, position_y: destination_y).present?
  end


  def checkmate?(user)
    king = self.pieces.find_by(type: 'King', user: user, captured: false)

    # game not in check if king is not in check
    return false if !in_check?(king)

    # if in check, check possible moves the king can make and see if it will still keep the king in check, or if it can evade capture.
    king_x = king.position_x
    king_y = king.position_y
    available_king_moves = [[king_x + 1, king_y], [king_x - 1, king_y], [king_x, king_y + 1], [king_x, king_y - 1],
    [king_x + 1, king_y + 1], [king_x - 1, king_y - 1], [king_x + 1, king_y - 1], [king_x - 1, king_y + 1]]
   
    available_king_moves.each { |move|
     if king.valid_move?(move[0], move[1])
       king.move_to!(move[0], move[1])
       if ! self.in_check?(king)
         king.update_attributes(:position_x => king_x, :position_y => king_y)
         return false
       end
     end
    } 
    return true 
  end

  def set_turn!
    turn_id = self.owner.id.to_i
    self.update_attribute(turn: turn_id)
  end

  def update_turn!
    opponent = self.owner.id
    owner = self.owner.id
    if self.turn_id == owner 
      update_attributes(turn_id: opponent)
    else
      self.update_attributes(turn_id: owner)
    end

  end

  private

  def piece_params
    params.require(:piece).permit(:type, :position_x, :position_y, :game_id, :color, :captured, :image)
  end
end 

