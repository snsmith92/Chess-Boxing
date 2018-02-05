class Game < ApplicationRecord
  scope :available, -> { where(black_player: nil) }
end
