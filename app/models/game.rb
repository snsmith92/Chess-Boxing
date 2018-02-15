class Game < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  belongs_to :opponent, class_name: 'User', foreign_key: 'opponent_id'

  scope :available, -> { where(Game.arel_table[:owner].not_eq(0)).where(opponent = nil) }

  def populate_game!(piece_params)
    Piece.create("Rook", 0, 0, @game.id, "white")
    Piece.create("Knight", 1, 0, @game.id, "white")
    Piece.create("Bishop", 2, 0, @game.id, "white")
    Piece.create("King", 3, 0, @game.id, "white")
    Piece.create("Queen", 4, 0, @game.id, "white")
    Piece.create("Bishop", 5, 0, @game.id, "white")
    Piece.create("Knight", 6, 0, @game.id, "white")
    Piece.create("Rook", 7, 0, @game.id, "white")
    Piece.create("Pawn", 0, 1, @game.id, "white")
    Piece.create("Pawn", 1, 1, @game.id, "white")
    Piece.create("Pawn", 2, 1, @game.id, "white")
    Piece.create("Pawn", 3, 1, @game.id, "white")
    Piece.create("Pawn", 4, 1, @game.id, "white")
    Piece.create("Pawn", 5, 1, @game.id, "white")
    Piece.create("Pawn", 6, 1, @game.id, "white")
    Piece.create("Pawn", 7, 1, @game.id, "white")

    Piece.create("Rook", 0, 7, @game.id, "black")
    Piece.create("Knight", 1, 7, @game.id, "black")
    Piece.create("Bishop", 2, 7, @game.id, "black")
    Piece.create("King", 3, 7, @game.id, "black")
    Piece.create("Queen", 4, 7, @game.id, "black")
    Piece.create("Bishop", 5, 7, @game.id, "black")
    Piece.create("Knight", 6, 7, @game.id, "black")
    Piece.create("Rook", 7, 7, @game.id, "black")
    Piece.create("Pawn", 0, 6, @game.id, "black")
    Piece.create("Pawn", 1, 6, @game.id, "black")
    Piece.create("Pawn", 2, 6, @game.id, "black")
    Piece.create("Pawn", 3, 6, @game.id, "black")
    Piece.create("Pawn", 4, 6, @game.id, "black")
    Piece.create("Pawn", 5, 6, @game.id, "black")
    Piece.create("Pawn", 6, 6, @game.id, "black")
    Piece.create("Pawn", 7, 6, @game.id, "black")

  end

  private

  def piece_params
    params.require(:piece).permit(:type, :position_x, :position_y, :game_id, :color, :captured)
  end
end
