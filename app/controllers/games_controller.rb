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
    @game.save!
    redirect_to game_path(@game)
  end

  def show
    @game = Game.find(params[:id])
    @pieces = Piece.where(game_id: @game)
  end

  def update
    puts "UPDATING"
    @game = Game.find(params[:id])
    byebug
    # if @game.valid? && @game.owner != current_user.id
    if @game.owner != current_user.id
      @game.update_attribute(:opponent, current_user.id)
      @game.save!
      puts "SAVED"
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
