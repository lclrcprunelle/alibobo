class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def create
    set_product
    @booking = Booking.new(booking_params)
    @booking.product = @product
    @booking.user = current_user

    if @booking.save
      redirect_to products_path
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
