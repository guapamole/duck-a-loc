class DucksController < ApplicationController

  def article_params
    params.require(:ducks).permit(:title, :description, :price, photos: [])
  end
end
