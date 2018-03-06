require 'rails_helper'

RSpec.describe Bishop, type: :model do
  describe "valid_move?" do
    it "should be able to move anywhere along a slope of 1" do
      user = FactoryBot.create(:user)
      game = FactoryBot.create(:game, owner: user)
      bish = FactoryBot.create(:bishop, type: "Bishop", game_id: game.id, moves: 0, position_x: 2, position_y: 2, captured: false)
      expect(bish.valid_move?(5, 5)).to eq(true)
    end
  end
end
