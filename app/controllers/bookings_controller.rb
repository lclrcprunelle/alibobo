class BookingsController < ApplicationController
  before_action :set_product, only: [:new, :create]

  def index
    @bookings = Booking.where(user: current_user)
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.product = @product
    @booking.user = current_user

    if @booking.save
      redirect_to products_path
    else
      render :new, layout: false, status: :unprocessable_entity
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :total_price)
  end
end
