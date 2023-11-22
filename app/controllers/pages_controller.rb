class PagesController < ApplicationController

  def dashboard
  end


  skip_before_action :authenticate_user!, only: :home
  def home

  end
end
