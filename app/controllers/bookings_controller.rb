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
    @duck = Duck.find(params[:duck_id])
    if current_user == @duck.user # Check if current_user owns the duck
      @booking = @duck.bookings.build(booking_params)
      @booking.user = current_user
      if @booking.save
        redirect_to dashboard_path
      else
        render :new, status: :unprocessable_entity
      end
    else
      # Unauthorized access - Redirect or show error message
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to dashboard_path
    end
  end

  def edit

  end

  def update
    @booking = Booking.find(params[:id])
    if current_user == @booking.duck.user
      if @booking.update(booking_params)
        redirect_to bookings_path
      else
        render :edit, status: :unprocessable_entity
      end
    else
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to bookings_path
    end
  end

  def destroy
    @booking.destroy
    redirect_to booking_path
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:date, :end_date, :user_id, :duck_id)
  end

  def validate_booking
    @booking.validated!
  end
end
