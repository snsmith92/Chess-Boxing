require 'rails_helper'

RSpec.describe Game, type: :model do
  context "in check" do
    it "detects that a game is in check" do
      #setup
      user = FactoryBot.create(:user)
      game = Game.create!(owner: user)
      game.pieces.destroy_all
      
      king = King.create(color: "white", game_id: game.id, position_x: 0, position_y: 2)
      rook = Rook.create(color: "black", game_id: game.id, position_x: 0 , position_y: 5)
      #execute and evaluate
      expect(game.in_check?).to eq(true)
    end 
  end 

  context "is_occupied?" do
    it "should detect if a cell is occupied" do
    end 
  end 

  context "checkmate method" do
    it "should return true if a game is in checkmate" do 
      user = FactoryBot.create(:user)
      game = Game.create!(id: 1, owner: user)
      game.pieces.destroy_all
      king = King.create(color: "white", game_id: game.id, position_x: 1, position_y: 0)
      rook1 = Rook.create(color: "black", game_id: game.id, position_x: 0, position_y: 3)
      rook2 = Rook.create(color: "black", game_id: game.id, position_x: 1, position_y: 3)
      queen = Queen.create(color: "black", game_id: game.id, position_x: 2, position_y: 3)
      expect(game.checkmate?).to eq(true)
    end

    it "should return false when a game is not in checkmate" do
      user = FactoryBot.create(:user)
      game = Game.create!(id: 1, owner: user)
      game.pieces.destroy_all
      king = King.create(color: "white", game_id: game.id, position_x: 1, position_y: 0)
      rook1 = Rook.create(color: "black", game_id: game.id, position_x: 0, position_y: 3)
      rook2 = Rook.create(color: "black", game_id: game.id, position_x: 1, position_y: 3)
      expect(game.checkmate?).to eq(false)
    end
  end
end
