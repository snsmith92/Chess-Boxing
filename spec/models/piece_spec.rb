require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe "is_obstructed_vertically" do
    it "should detect vertical obstructions between a piece and desired destination" do
      user = FactoryBot.create(:user)
      game = FactoryBot.create(:game, owner: user)
      piece = FactoryBot.create(:piece, game_id: game.id, position_x: 0, position_y: 0)
      piece_2 = FactoryBot.create(:piece, game_id: game.id, position_x: 0, position_y: 2)
      expect(piece.is_obstructed_vertically(0,7)).to eq(true)
    end
  end

  describe "is_obstructed_horizontally" do
    it "should detect horizontal obstructions between a piece and desired destination" do
      user = FactoryBot.create(:user)
      game = FactoryBot.create(:game, owner: user)
      piece = FactoryBot.create(:piece, game_id: game.id, position_x: 0, position_y: 0)
      piece_2 = FactoryBot.create(:piece, game_id: game.id, position_x: 2, position_y: 0)
      expect(piece.is_obstructed_horizontally(7,0)).to eq(true)
    end
  end

  describe "is_obstructed_diagonally" do
    it "should detect diagonal obstructions between a piece and a desired destination" do
      user = FactoryBot.create(:user)
      game = FactoryBot.create(:game, owner: user)
      piece = FactoryBot.create(:piece, game_id: game.id, position_x: 0, position_y: 0)
      piece_2 = FactoryBot.create(:piece, game_id: game.id, position_x: 2, position_y: 2)
      expect(piece.is_obstructed_diagonally(6, 6)).to eq(true)
    end
  end
end
