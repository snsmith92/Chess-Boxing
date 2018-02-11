class Game < ApplicationRecord
  scope :available, -> { where(Game.arel_table[:white_player].not_eq(0)).where(black_player: nil) }

  belongs_to :owner, class_name: "User", foreign_key: "owner_id"
  belongs_to :opponent, class_name: "User", foreign_key: "opponent_id"
end
