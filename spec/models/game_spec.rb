require 'rails_helper'

RSpec.describe Game, type: :model do
  context "game is in check" do
    it "detects that a game is in check" do
      game = Game.create
      king = game.pieces.create(type: "king", color: "white", position_x: 0, position_y: 2)
      rook = game.piece.create(type: "rook", color: "black", position_x: 0 , position_y: 5)
      expect(game.in_check?).to eq(true)
    end 
  end 
end
