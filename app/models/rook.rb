class Rook < Piece
  scope :rooks, -> {where(type: 'Rook')}

end