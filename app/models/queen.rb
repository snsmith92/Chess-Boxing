class Queen < Piece
  scope :queens, -> {where(type: 'Queen')}


end