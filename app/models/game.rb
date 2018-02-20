class Game < ApplicationRecord
  attr_accessor :owner, :opponent
  after_create :populate_game!

  belongs_to :owner, class_name: 'User', foreign_key: 'owner'
  belongs_to :opponent, class_name: 'User', foreign_key: 'opponent', optional: true

  scope :available, -> { where(Game.arel_table[:owner].not_eq(0)).where(opponent = nil) }
  
  def populate_game!(piece_params)
    current_game = self.id
    Piece.create("Rook", 0, 0, current_game, "white", false, "images/rook-white.png")
    Piece.create("Knight", 1, 0, @game.id, "white", false, "images/knight-white.png")
    Piece.create("Bishop", 2, 0, @game.id, "white", false, "images/bishop-white.png")
    Piece.create("King", 3, 0, @game.id, "white", false, "images/king-white.png")
    Piece.create("Queen", 4, 0, @game.id, "white", false, "images/queen-white.png")
    Piece.create("Bishop", 5, 0, @game.id, "white", false, "images/bishop-white.png")
    Piece.create("Knight", 6, 0, @game.id, "white", false, "images/knight-white.png")
    Piece.create("Rook", 7, 0, @game.id, "white", false, "images/rook-white.png")

    (0..7).each do |n|
      Piece.create("Pawn", n, 1, @game.id, "white", false, "images/pawn-white.png")
    end

    Piece.create("Rook", 0, 7, @game.id, "black", false, "images/rook-black.png")
    Piece.create("Knight", 1, 7, @game.id, "black", false, "images/knight-black.png")
    Piece.create("Bishop", 2, 7, @game.id, "black", false, "images/bishop-black.png")
    Piece.create("King", 3, 7, @game.id, "black", false, "images/king-black.png")
    Piece.create("Queen", 4, 7, @game.id, "black", false, "images/queen-black.png")
    Piece.create("Bishop", 5, 7, @game.id, "black", false, "images/bishop-black.png")
    Piece.create("Knight", 6, 7, @game.id, "black", false, "images/knight-black.png")
    Piece.create("Rook", 7, 7, @game.id, "black", false, "images/rook-black.png")

    (0..7).each do |n|
      Piece.create("Pawn", n, 6, @game.id, "black", false, "images/pawn-black.png")
    end
  end

  private

  def piece_params
    params.require(:piece).permit(:type, :position_x, :position_y, :game_id, :color, :captured, :image)
  end
end
