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
    binding.pry
    position_x = 
    position_y = 
    @piece.move_to!(position_x, position_y)
    # @piece.update_attributes(piece_params)
    redirect_to pieces_path(@piece)
  end

  private

  def piece_params
    params.require(:piece).permit(:position_x, :position_y)
  end
end 