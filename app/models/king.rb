class King < Piece
  scope :kings, -> {where(type: 'King')}


end
