class Bishop < Piece
  scope :piece, -> {where(type: 'Bishop')}

end