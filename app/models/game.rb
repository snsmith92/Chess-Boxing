class Game < ApplicationRecord
  attr_accessor :owner, :opponent
  after_create :populate_game!

  belongs_to :owner, class_name: 'User', foreign_key: 'owner'
  belongs_to :opponent, class_name: 'User', foreign_key: 'opponent', optional: true

  scope :available, -> { where(Game.arel_table[:owner].not_eq(0)).where(opponent = nil) }
  
  def populate_game!
    # white pieces 
    Piece.create(type: 'Rook', game_id: self.id, position_x: 0, position_y: 0, color: 'white', captured: false, image: 'rook-white.png')
    Piece.create(type: 'Knight', game_id: self.id, position_x: 1, position_y: 0, color: 'white', captured: false, image: 'knight-white.png')
    Piece.create(type: 'Bishop', game_id: self.id, position_x: 2, position_y: 0, color: 'white', captured: false, image: 'bishop-white.png')
    Piece.create(type: 'King', game_id: self.id, position_x: 3, position_y: 0, color: 'white', captured: false, image: 'king-white.png')
    Piece.create(type: 'Queen', game_id: self.id, position_x: 4, position_y: 0, color: 'white', captured: false, image: 'queen-white.png')
    Piece.create(type: 'Bishop', game_id: self.id, position_x: 5, position_y: 0, color: 'white', captured: false, image: 'bishop-white.png')
    Piece.create(type: 'Knight', game_id: self.id, position_x: 6, position_y: 0, color: 'white', captured: false, image: 'knight-white.png')
    Piece.create(type: 'Rook', game_id: self.id, position_x: 7, position_y: 0, color: 'white', captured: false, image: 'rook-white.png')

    (0..7).each do |n|
      Piece.create(type: 'Pawn', game_id: self.id, position_x: n, position_y: 1, color: 'white', captured: false, image: 'pawn-white.png')
    end

    Piece.create(type: 'Rook', game_id: self.id, position_x: 0, position_y: 7, color:'black', captured: false, image: 'rook-black.png')
    Piece.create(type: 'Knight', game_id: self.id, position_x: 1, position_y: 7, color: 'black', captured: false, image:'knight-black.png')
    Piece.create(type: 'Bishop', game_id: self.id, position_x: 2, position_y: 7, color: 'black', captured: false, image: 'bishop-black.png')
    Piece.create(type: 'King',game_id: self.id, position_x: 3, position_y: 7, color: 'black', captured: false, image: 'king-black.png')
    Piece.create(type: 'Queen', game_id: self.id, position_x: 4, position_y: 7, color: 'black', captured: false, image: 'queen-black.png')
    Piece.create(type: 'Bishop', game_id: self.id, position_x: 5, position_y: 7, color: 'black', captured: false, image: 'bishop-black.png')
    Piece.create(type: 'Knight', game_id: self.id, position_x: 6, position_y: 7, color: 'black', captured: false, image: 'knight-black.png')
    Piece.create(type: 'Rook', game_id: self.id, position_x: 7, position_y: 7, color: 'black', captured: false, image: 'rook-black.png')

    (0..7).each do |n|
      Piece.create(type: 'Pawn', game_id: self.id, position_x: n, position_y: 6, color: 'black', captured: false, image: 'pawn-black.png')
    end
  end

  private

  def piece_params
    params.require(:piece).permit(:type, :position_x, :position_y, :game_id, :color, :captured, :image)
  end
end
