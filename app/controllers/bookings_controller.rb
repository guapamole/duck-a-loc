class BookingsController < ApplicationController
  before_action :set_booking, only: [:edit, :update, :destroy, :accept, :decline]

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
    @booking.en_attente!
    if @booking.save
      redirect_to dashboard_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit

  end

  def update
    @duck = Duck.find(params[:duck_id])
    @booking.duck = @duck
    @booking.user = current_user
    if @booking.update(booking_params)
      redirect_to bookings_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @booking.destroy
    redirect_to booking_path
  end

  def accept
    @booking.validé!
    redirect_to dashboard_path
  end

  def decline
    @booking.refusé!
    redirect_to dashboard_path
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:date, :end_date, :user_id, :duck_id, :status)
  end


end
