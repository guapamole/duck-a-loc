class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def dashboard
    @bookings = current_user.bookings.order(created_at: :desc)
    @ducks = current_user.ducks.order(created_at: :desc)
  end

  def home

  end
end
