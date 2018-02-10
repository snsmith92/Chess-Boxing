class Game < ApplicationRecord
  scope :available, -> { where(Game.arel_table[:white_player].not_eq(0)).where(black_player: nil) }
end
