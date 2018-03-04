class Game < ApplicationRecord
  attr_accessor :owner, :opponent
  after_create :populate_game!

  belongs_to :owner, class_name: 'User' #, foreign_key: 'owner'
  belongs_to :opponent, class_name: 'User', foreign_key: 'opponent', optional: true
  has_many :pieces

  scope :available, -> { where(Game.arel_table[:owner_id].not_eq(0)).where(opponent_id = nil) }

  # image: 'rook-white.png'

  def populate_game!
    Rook.create(type: "Rook", game_id: self.id, position_x: 0, position_y: 0, color: "white", captured: false)
    Knight.create(type: "Knight", game_id: self.id, position_x: 1, position_y: 0, color: "white", captured: false)
    Bishop.create(type: "Bishop", game_id: self.id, position_x: 2, position_y: 0, color: "white", captured: false)
    King.create(type: "King", game_id: self.id, position_x: 3, position_y: 0, color: "white", captured: false)
    Queen.create(type: "Queen", game_id: self.id, position_x: 4, position_y: 0, color: "white", captured: false)
    Bishop.create(type: "Bishop", game_id: self.id, position_x: 5, position_y: 0, color: "white", captured: false)
    Knight.create(type: "Knight", game_id: self.id, position_x: 6, position_y: 0, color: "white", captured: false)
    Rook.create(type: "Rook", game_id: self.id, position_x: 7, position_y: 0, color: "white", captured: false)

    (0..7).each do |n|
      Pawn.create(type: "Pawn", game_id: self.id, position_x: n, position_y: 1, color: "white", captured: false)
    end

    Rook.create(type: "Rook", game_id: self.id, position_x: 0, position_y: 7, color: "black", captured: false)
    Knight.create(type: "Knight", game_id: self.id, position_x: 1, position_y: 7, color: "black", captured: false)
    Bishop.create(type: "Bishop", game_id: self.id, position_x: 2, position_y: 7, color: "black", captured: false)
    King.create(type: "King", game_id: self.id, position_x: 3, position_y: 7, color: "black", captured: false)
    Queen.create(type: "Queen", game_id: self.id, position_x: 4, position_y: 7, color: "black", captured: false)
    Bishop.create(type: "Bishop", game_id: self.id, position_x: 5, position_y: 7, color: "black", captured: false)
    Knight.create(type: "Knight", game_id: self.id, position_x: 6, position_y: 7, color: "black", captured: false)
    Rook.create(type: "Rook", game_id: self.id, position_x: 7, position_y: 7, color: "black", captured: false)

    (0..7).each do |n|
      Pawn.create(type: "Pawn", game_id: self.id, position_x: n, position_y: 6, color: "black", captured: false)
    end
  end

  def in_check?
    self.king.each do
      if king.color == 'black'
        black_in_check(position_x, position_y)
      else 
        white_in_check(position_x, position_y)
      end 
    end 
  end 

  private

  def piece_params
    params.require(:piece).permit(:type, :position_x, :position_y, :game_id, :color, :captured, :image)
  end

  def black_in_check(position_x, position_y)
    self.piece.each do 
      if piece.valid_move?(position_x, position_y) && piece.color == 'white' && piece.type != 'King'
        return true
      else 
        return false
      end 
  end 


  def white_in_check(position_x, position_y)
    self.piece.each do 
      if piece.valid_move?(position_x, position_y) && piece.color == 'black' && piece.type != 'King'
        return true
      else 
        return false
      end 
  end 
end
