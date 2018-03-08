class Game < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: 'owner'
  belongs_to :opponent, class_name: 'User', foreign_key: 'opponent', optional: true

  scope :available, -> { where(Game.arel_table[:owner].not_eq(0)).where(opponent = nil) }

  def populate_game!(piece_params)
    Piece.create("Rook", 0, 0, @game.id, "white", false)
    Piece.create("Knight", 1, 0, @game.id, "white", false)
    Piece.create("Bishop", 2, 0, @game.id, "white", false)
    Piece.create("King", 3, 0, @game.id, "white", false)
    Piece.create("Queen", 4, 0, @game.id, "white", false)
    Piece.create("Bishop", 5, 0, @game.id, "white", false)
    Piece.create("Knight", 6, 0, @game.id, "white", false)
    Piece.create("Rook", 7, 0, @game.id, "white", false)

    (0..7).each do |n|
      Piece.create("Pawn", n, 1, @game.id, "white", false)
    end

    Piece.create("Rook", 0, 7, @game.id, "black", false)
    Piece.create("Knight", 1, 7, @game.id, "black", false)
    Piece.create("Bishop", 2, 7, @game.id, "black", false)
    Piece.create("King", 3, 7, @game.id, "black", false)
    Piece.create("Queen", 4, 7, @game.id, "black", false)
    Piece.create("Bishop", 5, 7, @game.id, "black", false)
    Piece.create("Knight", 6, 7, @game.id, "black", false)
    Piece.create("Rook", 7, 7, @game.id, "black", false)

    (0..7).each do |n|
      Piece.create("Pawn", n, 6, @game.id, "black", false)
    end
  end

  def self.in_check?
    @game.king.each do
      queen_bishop_check
      queen_rook_check
      knight_check
      pawn_check
    end
  end

  private


  def piece_params
    params.require(:piece).permit(:type, :position_x, :position_y, :game_id, :color, :captured)
  end

  def queen_bishop_check
    #checking if the king is obstructed diagonally by a queen or a bishop of the opposite color
    #this would mean the king is in check
    if @king.is_obstructed_diagonally(self.position_x, self.position_y) && 

    end
  end

  def queen_rook_check
    #checking if the king is obstructed horizontally or vertically by a queen or a rook of the opposite color
    if @king.is_obstructed_vertically(self.position_x, self.position_y) && 

    end

    if @king.is_obstructed_horizontally(self.position_x, self.position_y) &&

    end
  end

  def knight_check
    #checking if there is a knight within a valid move from the king

  end

  def pawn_check
    #checking to see if there is a pawn to the immediate diagonal of the king
    #this will be tricky because pawns cannot capture diagonally backwards!
  end

end










