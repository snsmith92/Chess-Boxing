require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe "games#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end  

  describe "games#new action" do
    it "should require users to be logged in" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully show the new form" do
      user = FactoryBot.create(:user)
      sign_in user

      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "games#create action" do
    it "should require users to be logged in" do
      user = FactoryBot.create(:user)
      post :create, param: { game: {owner: user}}
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully create a new game in the database with current user as the owner" do
      user = FactoryBot.create(:user)
      sign_in user
      post :create, params: { game: {name: "Test" } }
      expect(response).to redirect_to root_path

      game = Game.last
      expect(game.name).to eq("Test")
      expect(game.owner).to eq(user)

    end 
  end 

  describe "games#update action" do
    it "should not allow unauthenticated users to join a game" do
      user_1 = FactoryBot.create(:user)
      user_2 = FactoryBot.create(:user)
      game = FactoryBot.create(:game, owner: user_1, opponent: nil)

      patch :update, params: { id: game.id, game: { owner: user_1, opponent: user_2 } }
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully update attributes for opponent" do
      user_1 = FactoryBot.create(:user)
      user_2 = FactoryBot.create(:user)
      sign_in user_2

      game = FactoryBot.create(:game, owner: user_1, opponent: nil)
      patch :update, params: { id: game.id, game: { owner: user_1, opponent: user_2 } }
      
    end

    it "should successfully populate game and go to show page" do
      user_1 = FactoryBot.create(:user)
      user_2 = FactoryBot.create(:user)
      sign_in user_2

      game = FactoryBot.create(:game, owner: user_1, opponent: nil)
      patch :update, params: { id: game.id, game: { owner: user_1, opponent: user_2 } }
      
      expect(game.pieces.count).to eq(32)
      expect(response).to redirect_to game_path(game)
    end 
  end

  describe "games#show action" do
    it "should only show the game to signed in users" do
      user = FactoryBot.create(:user)
      game = FactoryBot.create(:game, owner: user, opponent: nil)

      get :show, params: { id: game.id }
      expect(response).to redirect_to new_user_session_path
    end 

    it "should successfully show the game if the game is found" do
      user_1 = FactoryBot.create(:user)
      user_2 = FactoryBot.create(:user)
      game = FactoryBot.create(:game, owner: user_1, opponent: user_2)

      sign_in user_1

      get :show, params: { id: game.id }
      expect(response).to have_http_status(:success)
    end 

    it "should return 404 error if the game is not found" do
      user = FactoryBot.create(:user)
      sign_in user

      get :show, params: { id: 'Test'}
      expect(response).to have_http_status(:not_found)
    end 

  end 
end
