require 'rails_helper'

RSpec.describe Pawn, type: :model do
  describe "valid_move?" do
    it "should be able to move two spaces vertically if it hasn't moved" do
        user = FactoryBot.create(:user)
        game = Game.create!(owner: user)
        pawn = Pawn.create(user: user, game_id: game.id, moves: 0, position_x: 0, position_y: 3)
        expect(pawn.valid_move?(0, 5)).to eq(true)
      end
    end

  describe "valid_move?" do
    it "should only be able to move 1 space if it has moved" do
      user = FactoryBot.create(:user)
      game = Game.create!(owner: user)
      pawn = Pawn.create(user: user, game_id: game.id, moves: 1, position_x: 0, position_y: 2)
      expect(pawn.valid_move?(0, 4)).to eq(false)
    end
  end

  describe "valid_move?" do
    it "should return true if a pawn tries to capture diagonally" do
      user = FactoryBot.create(:user)
      opponent = FactoryBot.create(:user)
      game = Game.create!(owner: user, opponent: opponent)
      white_pawn = Pawn.create(user: user, game_id: game.id, color: "white", position_x: 2, position_y: 3)
      black_knight = Knight.create(user: opponent, game_id: game.id, color: "black", position_x: 3, position_y: 4)
      expect(white_pawn.valid_move?(3,4)).to eq(true)
    end
  end

  describe "valid_move?" do
    it "should return false if a pawn tries to capture to the front" do
      user = FactoryBot.create(:user)
      opponent = FactoryBot.create(:user)
      game = Game.create!(owner: user, opponent: opponent)
      white_pawn = Pawn.create(user: user, game_id: game.id, color: "white", position_x: 2, position_y: 3)
      black_knight = Knight.create(user: opponent, game_id: game.id, color: "black", position_x: 3, position_y: 4)
      black_rook = Rook.create(user: opponent, game_id: game.id, color: "black", position_x: 2, position_y: 4)
      expect(white_pawn.valid_move?(2,4)).to eq(false)
    end
  end
end
