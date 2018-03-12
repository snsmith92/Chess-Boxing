class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new]

  def index
    @games = Game.available
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
    @game.update_attributes(:owner => current_user)
    @game.save!
    redirect_to root_path
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
      @game.update_attribute(:opponent, current_user)
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
