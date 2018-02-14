class Pawn < Piece
  scope :piece, -> {where(type: 'Pawn')}


end