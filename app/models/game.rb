class Game < ApplicationRecord
  attr_accessor :owner, :opponent
  after_create :populate_game!

  belongs_to :owner, class_name: 'User', foreign_key: 'owner'
  belongs_to :opponent, class_name: 'User', foreign_key: 'opponent', optional: true

  scope :available, -> { where(Game.arel_table[:owner].not_eq(0)).where(opponent = nil) }
  
  # image: 'rook-white.png'

  def populate_game!
    # white pieces 
    Piece.create(type: 'Rook', game_id: self.id, position_x: 0, position_y: 0, color: 'white', captured: false)
    Piece.create(type: 'Knight', game_id: self.id, position_x: 1, position_y: 0, color: 'white', captured: false)
    Piece.create(type: 'Bishop', game_id: self.id, position_x: 2, position_y: 0, color: 'white', captured: false)
    Piece.create(type: 'King', game_id: self.id, position_x: 3, position_y: 0, color: 'white', captured: false)
    Piece.create(type: 'Queen', game_id: self.id, position_x: 4, position_y: 0, color: 'white', captured: false)
    Piece.create(type: 'Bishop', game_id: self.id, position_x: 5, position_y: 0, color: 'white', captured: false)
    Piece.create(type: 'Knight', game_id: self.id, position_x: 6, position_y: 0, color: 'white', captured: false)
    Piece.create(type: 'Rook', game_id: self.id, position_x: 7, position_y: 0, color: 'white', captured: false)

    (0..7).each do |n|
      Piece.create(type: 'Pawn', game_id: self.id, position_x: n, position_y: 1, color: 'white', captured: false)
    end

    Piece.create(type: 'Rook', game_id: self.id, position_x: 0, position_y: 7, color:'black', captured: false)
    Piece.create(type: 'Knight', game_id: self.id, position_x: 1, position_y: 7, color: 'black', captured: false)
    Piece.create(type: 'Bishop', game_id: self.id, position_x: 2, position_y: 7, color: 'black', captured: false)
    Piece.create(type: 'King',game_id: self.id, position_x: 3, position_y: 7, color: 'black', captured: false)
    Piece.create(type: 'Queen', game_id: self.id, position_x: 4, position_y: 7, color: 'black', captured: false)
    Piece.create(type: 'Bishop', game_id: self.id, position_x: 5, position_y: 7, color: 'black', captured: false)
    Piece.create(type: 'Knight', game_id: self.id, position_x: 6, position_y: 7, color: 'black', captured: false)
    Piece.create(type: 'Rook', game_id: self.id, position_x: 7, position_y: 7, color: 'black', captured: false)

    (0..7).each do |n|
      Piece.create(type: 'Pawn', game_id: self.id, position_x: n, position_y: 6, color: 'black', captured: false)
    end
  end

  private

  def piece_params
    params.require(:piece).permit(:type, :position_x, :position_y, :game_id, :color, :captured, :image)
  end
end
