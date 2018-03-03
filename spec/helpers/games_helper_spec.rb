require 'rails_helper'

RSpec.describe GamesHelper, type: :model do

  describe "Game" do
    context "at the very beginning of a game"
      it "should successfully populate the game board with piece objects" do
        user = FactoryBot.create(:user)
        game = FactoryBot.create(:game, owner: user)
        game.populate_game!
        expect(game.pieces.count).to eq(64)
    end
  end
end
