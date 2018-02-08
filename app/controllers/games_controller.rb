class GamesController < ApplicationController
  def index
    @games = Game.where(black_player: nil).or Game.where(white_player: nil)
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
  end

private

  def game_params
    params.require(:game).permit(:name)
  end

end
