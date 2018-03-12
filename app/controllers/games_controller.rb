class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
    @game.update_attributes(:owner => current_user)
    # @game.owner_id = current_user
    @game.save!
    # @game.owner = current_user.id
    # @game = current_user.started_games.create(game_params)
    # @game = Game.create(game_params)
    # @game.owner = curent_user
    # @game.save
    # @game.update_attribute(:owner, current_user)
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
    # byebug
    # if @game.valid? && @game.owner != current_user.id
    if @game.owner != current_user.id
      @game.update_attribute(:opponent, current_user.id)
      @game.save
      redirect_to game_path(@game)
    else
      render :new, status: :unprocessable_entity
    end
  end

private

  def game_params
    params.require(:game).permit(:name, :owner, :opponent)
  end

end
