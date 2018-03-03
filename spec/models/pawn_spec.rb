require 'rails_helper'

RSpec.describe Pawn, type: :model do
  describe "valid_move" do
    it "should be able to move two spaces vertically if it hasn't moved"
      user = FactoryBot.create(:user)
      game = FactoryBot.create(:game, owner: user)
      pawn = FactoryBot.create(:piece, type: "Pawn", position_x: 0, position_y: 1)
      expect(pawn.move_to!)
