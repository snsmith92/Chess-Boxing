class Game < ApplicationRecord
  scope :available, -> { where(black_player: nil, white_player != current_user) }
end
