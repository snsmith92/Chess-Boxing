class Knight < Piece
  scope :knight, -> {where(type: 'Knight')}


end