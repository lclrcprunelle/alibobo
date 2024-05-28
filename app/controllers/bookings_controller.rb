class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def new
    set_product
    @booking = Booking.new
  end

  def create
    set_product
    @booking = Booking.new(booking_params)
    @booking.product = @product
    if @booking.save
      redirect_to products_path
    else
      render :new, status: :unprocessable_entity
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
