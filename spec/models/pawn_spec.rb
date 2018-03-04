require 'rails_helper'

RSpec.describe Pawn, type: :model do
  describe "valid_move?" do
    it "should be able to move two spaces vertically if it hasn't moved" do
        user = FactoryBot.create(:user)
        game = FactoryBot.create(:game, owner: user)
        pawn = FactoryBot.create(:piece, type: "Pawn", game_id: game.id, position_x: 0, position_y: 1)
        pawn.move_to!(0, 3)
        expect(pawn.position_y).to eq(3)
      end
    end
  end
