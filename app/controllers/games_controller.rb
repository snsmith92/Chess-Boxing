class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new, :update, :show ]

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
    @game = Game.find_by_id(params[:id])
    @pieces = Piece.where(game_id: @game)
    return render plain: "Not Found", status: :not_found if @game.blank? 
    redirect_to new_user_session_path if !user_signed_in?
  end
    

  def update
    @game = Game.find(params[:id])
    if @game.owner != current_user.id
      opponent = current_user
      set_turn = @game.owner.id.to_i
      @game.update_attributes(opponent: current_user, turn_id: set_turn)
      @game.populate_game!
      @game.save
      redirect_to game_path(@game)
    else
      render :index, status: :unprocessable_entity
    end
  end

private

  def game_params
    params.require(:game).permit(:name, :owner, :opponent, :game_id, :turn_id)
  end

end
