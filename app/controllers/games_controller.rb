class GamesController < ApplicationController
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
    # byebug
    # if @game.valid? && @game.owner != current_user.id
    if @game.owner != current_user.id
      @game.update_attribute(:opponent, current_user.id)
      @game.save
      if current_user.in_check?
        flash[:alert] = "You're in check!"
      end
    redirect_to game_path(@game)
    else
      render :new, status: :unprocessable_entity
    end
  end

private

  def game_params
    params.require(:game).permit(:name, :owner, :opponent, :game_id)
  end

end
