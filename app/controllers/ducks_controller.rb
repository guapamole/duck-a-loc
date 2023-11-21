class DucksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @ducks = Duck.all
  end

  def show
    @duck = Duck.find(params[:id])
  end



private


  def article_params
    params.require(:ducks).permit(:title, :description, :price, :photo)
  end
end
