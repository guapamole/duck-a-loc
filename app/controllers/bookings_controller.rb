class BookingsController < ApplicationController
  before_action :set_booking, only: [:edit, :update, :destroy]

  def index
    @bookings = Booking.all
  end

  def new

    @duck = Duck.find(params[:duck_id])
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @duck = Duck.find(params[:duck_id])
    @booking.duck = @duck
    @booking.user = current_user
    @booking.save
    redirect_to dashboard_path
  end

  def edit
  end

  def update
    @booking.update(booking_params)
    redirect_to bookings_path
  end

  def destroy
    @booking.destroy
    redirect_to bookings_path
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:date, :user_id, :duck_id)
  end
end
