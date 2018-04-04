require 'rails_helper'

RSpec.describe Piece, type: :model do

  context 'is_obstructed?' do
    it 'should detect if there are vertical obstructions between a piece and desired destination' do 
      user = FactoryBot.create(:user)
      game = Game.create!(owner: user)
      game.pieces.destroy_all
      piece_1 = Piece.create!(user: user, position_x: 0, position_y: 0, game_id: game.id)
      piece_2 = Piece.create!(user: user, position_x: 0, position_y: 2, game_id: game.id)
      expect(piece_1.is_obstructed?(0,7)).to eq(true)
    end 

    it 'should detect if there are no vertical obstructions between a piece and desired destination' do 
      user = FactoryBot.create(:user)
      game = Game.create!(owner: user)
      game.pieces.destroy_all
      piece_1 = Piece.create!(user: user, position_x: 0, position_y: 0, game_id: game.id)
      piece_2 = Piece.create!(user: user, position_x: 0, position_y: 7, game_id: game.id)
      expect(piece_1.is_obstructed?(0,2)).to eq(false)
    end 

    it 'should detect diagonal obstructions between a piece and desired destination' do
      user = FactoryBot.create(:user)
      game = Game.create!(owner: user)
      game.pieces.destroy_all
      piece_1 = Piece.create!(user: user, position_x: 0, position_y: 0, game_id: game.id)
      piece_2 = Piece.create!(user: user, position_x: 2, position_y: 2, game_id: game.id)
      expect(piece_1.is_obstructed?(3,3)).to eq(true)
    end

    it 'should detect if there are horizontal obstructions between a piece and desired destination' do
      user = FactoryBot.create(:user)
      game = Game.create!(id: 1, owner: user)
      game.pieces.destroy_all
      piece_1 = Piece.create!(user: user, position_x: 0, position_y: 0, game_id: game.id)
      piece_2 = Piece.create!(user: user, position_x: 2, position_y: 0, game_id: game.id)
      expect(piece_1.is_obstructed?(5,0)).to eq(true)
    end

    it 'should detect if there are no horizontal obstructions between a piece and desired destination' do
      user = FactoryBot.create(:user)
      game = Game.create!(id: 1, owner: user)
      game.pieces.destroy_all
      piece_1 = King.create!(user: user, position_x: 0, position_y: 0, game_id: game.id)
      piece_2 = Bishop.create!(user: user, position_x: 5, position_y: 0, game_id: game.id)
      expect(piece_1.is_obstructed?(2,0)).to eq(false)
    end

  end

  context "move_to!" do
    it "should update attributes if a move is valid" do


    end 

    it "should not update attributes if a move is invalid" do
      
    end
  end 
end
