class PiecesController < ApplicationController
  def index
  end

  def sp(path)
    "Selected Piece" if current_page?(path)
  end

  def show
    @piece = Piece.find(params[:id])    
  end

  def update
    @piece = Piece.find(params[:id])
    @game = @piece.game
    position_x = params[:piece][:position_x].to_i
    position_y = params[:piece][:position_y].to_i
    @piece.move_to!(position_x, position_y)
    if @piece.move_to!(position_x, position_y) == true 
      @game.update_turn
    else 
      flash[:alert] = "This move is not allowed!"
    end 
    redirect_to pieces_path(@piece)
  end

  private

  def piece_params
    params.require(:piece).permit(:game_id, :position_x, :position_y)
  end
end 