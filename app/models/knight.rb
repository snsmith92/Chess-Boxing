class Knight < Piece
  scope :piece, -> {where(type: 'Knight')}


end