require 'rails_helper'

RSpec.describe Pawn, type: :model do
  describe "valid_move?" do
    it "should be able to move two spaces vertically if it hasn't moved" do
        user = FactoryBot.create(:user)
        game = FactoryBot.create(:game, owner: user)
        pawn = FactoryBot.create(:pawn, type: "Pawn", game_id: game.id, moves: 0, position_x: 0, position_y: 1)
        expect(pawn.valid_move?(0, 3)).to eq(true)
      end
    end

  describe "valid_move?" do
    it "should only be able to move 1 space if it has moved" do
      user = FactoryBot.create(:user)
      game = FactoryBot.create(:game, owner: user)
      pawn = FactoryBot.create(:pawn, type: "Pawn", game_id: game.id, moves: 1, position_x: 0, position_y: 1)
      expect(pawn.valid_move?(0, 3)).to eq(false)
    end
  end
end
