class DucksController < ApplicationController

  def show
    @duck = Duck.find(params[:id])
  end


  def article_params
    params.require(:ducks).permit(:title, :description, :price, photos: [])
  end
end
