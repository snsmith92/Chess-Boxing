class Rook < Piece
  scope :piece, -> {where(type: 'Rook')}

end