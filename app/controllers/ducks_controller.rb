class DucksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @ducks = Duck.all
  end

  def show
    @duck = Duck.find(params[:id])
  end

  def new
    @duck = Duck.new
  end

  def create
    @duck = Duck.new(ducks_params)
    @duck.user = current_user
    if @duck.save
      redirect_to ducks_path
    else
      render new, status: :unprocessable_entity
    end
  end


private


  def ducks_params
    params.require(:ducks).permit(:title, :price, :photo)
  end
end
