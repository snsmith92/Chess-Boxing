class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :update, :show] 

  def index
    @games = Game.available
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.owner = current_user
    @game.save
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
    @pieces = Piece.where(game_id: @game)
    if user_signed_in? == false
      redirect_to new_user_session_path
    end
  end

  def update
    @game = Game.find(params[:id])

    if @game.owner != current_user
      @game.update_attribute(:opponent, current_user)
      @game.save
      redirect_to game_path(@game)
    else
      render :index, status: :unprocessable_entity
    end
  end

private

  def game_params
    params.require(:game).permit(:name, :owner, :opponent, :game_id, :turn)
  end

end
