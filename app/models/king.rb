class King < Piece
  scope :piece, -> {where(type: 'King')}


end
