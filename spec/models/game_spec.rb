require 'rails_helper'

RSpec.describe Game, type: :model do
  context "in check" do
    it "detects that a game is in check" do
      #setup
      game = Game.create(id: 1)
      king = King.create(color: "white", game_id: 1, position_x: 0, position_y: 2)
      rook = Rook.create(color: "black", game_id: 1, position_x: 0 , position_y: 5)
      #execute 

      #evaluate
      expect(game.in_check?).to eq(true)
    end 
  end 
end
