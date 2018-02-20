require 'rails_helper'

RSpec.describe GamesHelper, type: :model do

  describe "Game" do
    context "at the very beginning of a game"
      it "should successfully populate the game board with piece objects" do
        game = FactoryBot.create(:game, :opponent)
        game.populate_game!
        expect(game.pieces.count).to eq([16])
    end
  end
end
