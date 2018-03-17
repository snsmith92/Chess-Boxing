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
end
