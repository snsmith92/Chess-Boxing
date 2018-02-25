require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe "is_obstructed_vertically" do
    it "should detect vertical obstructions between a piece and desired destination" do 
      user = FactoryBot.create(:user)
      sign_in user
      game = FactoryBot.create(:game, id: 1, owner: user)
      piece_1 = FactoryBot.create(:piece, game_id: 1, position_x: 0, position_y: 0)
      piece_2 = FactoryBot.create(:piece, game_id: 1, position_x: 0, position_y: 2)
      expect(piece_1.is_obstructed_vertically(0,7)).to eq(true)
    end 
  end
end
