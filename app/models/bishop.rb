class Bishop < Piece
  scope :bishops, -> {where(type: 'Bishop')}

end