require 'rails_helper'

RSpec.describe Game, type: :model do
  context "in check" do
    it "detects that a game is in check" do
      #setup
      user_1 = FactoryBot.create(:user)
      user_2 = FactoryBot.create(:user)
      game = Game.create!(owner: user_1, opponent: user_2)
      game.pieces.destroy_all
      
      king = King.create!(color: "white", game_id: game.id, position_x: 0, position_y: 2, user: user_1, captured: false)
      rook = Rook.create!(color: "black", game_id: game.id, position_x: 0 , position_y: 5, user: user_2, captured: false)
      #execute and evaluate
      expect(game.in_check?(king)).to eq(true)
      Game.destroy(game.id)
    end 
  end 

  context "is_occupied?" do
    it "should detect if a cell is occupied" do
    end 
  end 

  context "checkmate method" do
    it "should return true if a game is in checkmate" do 
      user_1 = FactoryBot.create(:user)
      user_2 = FactoryBot.create(:user)
      game = Game.create!(owner: user_1, opponent: user_2)
      game.pieces.destroy_all
      king = King.create!(color: "white", game_id: game.id, position_x: 1, position_y: 0, user: user_1, captured: false)
      rook1 = Rook.create!(color: "black", game_id: game.id, position_x: 0, position_y: 3, user: user_2, captured: false)
      rook2 = Rook.create!(color: "black", game_id: game.id, position_x: 1, position_y: 3, user: user_2, captured: false)
      queen = Queen.create!(color: "black", game_id: game.id, position_x: 2, position_y: 3, user: user_2, captured: false)
      user = king.user
      expect(game.checkmate?(user)).to eq(true)
      Game.destroy(game.id)
    end

    it "should return false when a game is not in checkmate" do
      user_1 = FactoryBot.create(:user)
      user_2 = FactoryBot.create(:user)
      game = Game.create!(id: 1, owner: user_1, opponent: user_2)
      game.pieces.destroy_all
      king = King.create(color: "white", game_id: game.id, position_x: 1, position_y: 0, user: user_1, captured: false)
      rook1 = Rook.create(color: "black", game_id: game.id, position_x: 0, position_y: 3, user: user_2, captured: false)
      rook2 = Rook.create(color: "black", game_id: game.id, position_x: 1, position_y: 3, user: user_2, captured: false)
      user = king.user
      expect(game.checkmate?(user)).to eq(false)
      Game.destroy(game.id)
    end
  end
end
