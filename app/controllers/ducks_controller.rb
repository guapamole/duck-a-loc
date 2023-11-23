class DucksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_duck, only: [:show, :destroy]

  def index
    @ducks = Duck.all
  end

  def show

  end

  def new
    @duck = Duck.new
  end

  def create
    @duck = Duck.new(ducks_params)
    @duck.user = current_user
    if @duck.save
      redirect_to dashboard_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @duck.destroy
    redirect_to dashboard_path
  end


private
  def set_duck
    @duck = Duck.find(params[:id])
  end

  def ducks_params
    params.require(:duck).permit(:title, :price, :photo)
  end
end
