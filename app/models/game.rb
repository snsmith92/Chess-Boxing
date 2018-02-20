class Game < ApplicationRecord
  attr_accessor :owner, :opponent
  after_create :populate_game!

  belongs_to :owner, class_name: 'User', foreign_key: 'owner'
  belongs_to :opponent, class_name: 'User', foreign_key: 'opponent', optional: true

  scope :available, -> { where(Game.arel_table[:owner].not_eq(0)).where(opponent = nil) }
  
  def populate_game!
    # white pieces 
    Piece.create(type: 'Rook', game_id: self.id, position_x: 0, position_y: 0, color: 'white', captured: false, image: '/images/rook-white.png')
    Piece.create(type: 'Knight', game_id: self.id, position_x: 1, position_y: 0, color: 'white', captured: false, image: 'assets/images/knight-white.png')
    Piece.create(type: 'Bishop', game_id: self.id, position_x: 2, position_y: 0, color: 'white', captured: false, image: 'assets/images/bishop-white.png')
    Piece.create(type: 'King', game_id: self.id, position_x: 3, position_y: 0, color: 'white', captured: false, image: 'assets/images/king-white.png')
    Piece.create(type: 'Queen', game_id: self.id, position_x: 4, position_y: 0, color: 'white', captured: false, image: 'assets/images/queen-white.png')
    Piece.create(type: 'Bishop', game_id: self.id, position_x: 5, position_y: 0, color: 'white', captured: false, image: 'assets/images/bishop-white.png')
    Piece.create(type: 'Knight', game_id: self.id, position_x: 6, position_y: 0, color: 'white', captured: false, image: 'assets/images/knight-white.png')
    Piece.create(type: 'Rook', game_id: self.id, position_x: 7, position_y: 0, color: 'white', captured: false, image: 'assets/images/rook-white.png')

    (0..7).each do |n|
      Piece.create(type: 'Pawn', game_id: self.id, position_x: n, position_y: 1, color: 'white', captured: false, image: 'images/pawn-white.png')
    end

    Piece.create(type: 'Rook', game_id: self.id, position_x: 0, position_y: 7, color:'black', captured: false, image: 'images/rook-black.png')
    Piece.create(type: 'Knight', game_id: self.id, position_x: 1, position_y: 7, color: 'black', captured: false, image:'images/knight-black.png')
    Piece.create(type: 'Bishop', game_id: self.id, position_x: 2, position_y: 7, color: 'black', captured: false, image: 'images/bishop-black.png')
    Piece.create(type: 'King',game_id: self.id, position_x: 3, position_y: 7, color: 'black', captured: false, image: 'images/king-black.png')
    Piece.create(type: 'Queen', game_id: self.id, position_x: 4, position_y: 7, color: 'black', captured: false, image: 'images/queen-black.png')
    Piece.create(type: 'Bishop', game_id: self.id, position_x: 5, position_y: 7, color: 'black', captured: false, image: 'images/bishop-black.png')
    Piece.create(type: 'Knight', game_id: self.id, position_x: 6, position_y: 7, color: 'black', captured: false, image: 'images/knight-black.png')
    Piece.create(type: 'Rook', game_id: self.id, position_x: 7, position_y: 7, color: 'black', captured: false, image: 'images/rook-black.png')

    (0..7).each do |n|
      Piece.create(type: 'Pawn', game_id: self.id, position_x: n, position_y: 6, color: 'black', captured: false, image: 'images/pawn-black.png')
    end
  end

  private

  def piece_params
    params.require(:piece).permit(:type, :position_x, :position_y, :game_id, :color, :captured, :image)
  end
end
