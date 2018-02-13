class Piece < ApplicationRecord
  belongs_to :game
  delegate :king, :queen, :bishop, :knight, :rook, :pawn, to: :pieces

  #needs models that inherit from piece called pawn, rook, knight, bishop, queen, king
end
