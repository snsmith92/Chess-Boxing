require 'rails_helper'

RSpec.describe Knight, type: :model do 
  describe "valid_move?" do
    it "should return true for a move 2 spaces in one direction and 1 space in the other" do
      user = FactoryBot.create(:user)
      game = FactoryBot.create(:game, owner: user)
      knight = FactoryBot.create(:knight, type: "Knight", game_id: game.id, moves: 0, position_x: 1, position_y: 2)
      expect(knight.valid_move?(3, 3)).to eq(true)
    end
  end

  describe "valid_move?" do
    it "should return false for a move 3 spaces in one direction" do
      user = FactoryBot.create(:user)
      game = FactoryBot.create(:game, owner: user)
      knight = FactoryBot.create(:knight, type: "Knight", game_id: game.id, moves: 0, position_x: 1, position_y: 2)
      expect(knight.valid_move?(1, 5)).to eq(false)
    end
  end
  
end
