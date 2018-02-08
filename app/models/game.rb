class Game < ApplicationRecord
  has_many :pieces
  has_one :black_player
  has_one :white_player
end
