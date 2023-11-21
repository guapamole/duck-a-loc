class DucksController < ApplicationController

  def index
    @ducks = Duck.all
  end

  def show
    @duck = Duck.find(params[:id])
  end

private

  def article_params
    params.require(:ducks).permit(:title, :description, :price, photos: [])
  end
end
