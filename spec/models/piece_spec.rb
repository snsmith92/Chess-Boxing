require 'rails_helper'

RSpec.describe Piece, type: :model do

  context "is_obstructed?" do
    it "should detect vertical obstructions between a piece and desired destination" do 
      game = Game.create
      piece_1 = Piece.create(position_x: 0, position_y: 0, game_id: game.id)
      piece_2 = Piece.create(position_x: 0, position_y: 2, game_id: game.id)
      expect(piece_1.is_obstructed?(0,7)).to eq(true)
    end 

    it "should detect diagonal obstructions between a piece and desired destination" do
      game = Game.create
      piece_1 = Piece.create(position_x: 0, position_y: 0, game_id: game.id)
      piece_2 = Piece.create(position_x: 2, position_y: 2, game_id: game.id)
      expect(piece_1.is_obstructed?(3,3)).to eq(true)
    end

    it "should detect horizontal obstructions between a piece and desired destination" do
      game = Game.create
      piece_1 = Piece.create(position_x: 0, position_y: 0, game_id: game.id)
      piece_2 = Piece.create(position_x: 2, position_y: 0, game_id: game.id)
      expect(piece_1.is_obstructed?(5,0)).to eq(true)
    end

  end
end
