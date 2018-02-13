class Pawn < Piece
  scope :pawns, -> {where(type: 'Pawn')}


end