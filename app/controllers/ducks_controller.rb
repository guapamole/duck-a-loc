class DucksController < ApplicationController

  def index
    @ducks = Duck.all
  end

  def show
    @duck = Duck.find(params[:id])
  end


  def article_params
    params.require(:ducks).permit(:title, :description, :price, :photo)
  end
end
