class Game < ApplicationRecord
  scope :available, -> { where(opponent_id: nil) }
end
