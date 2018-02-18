class Game < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  belongs_to :opponent, class_name: 'User', foreign_key: 'opponent_id'

  scope :available, -> { where(Game.arel_table[:owner].not_eq(0)).where(opponent = nil) }

end
