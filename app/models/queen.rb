class Queen < Piece
  scope :piece, -> {where(type: 'Queen')}


end