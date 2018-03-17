require 'rails_helper'

RSpec.describe Bishop, type: :model do
  describe "valid_move?" do
    it "should be able to move anywhere along a slope of 1" do
      user = FactoryBot.create(:user)
      game = FactoryBot.create(:game, owner: user)

      bishop = Bishop.create(game_id: game.id, position_x: 2, position_y: 2)
      expect(bishop.valid_move?(5, 5)).to eq(true)
    end
  end
end
