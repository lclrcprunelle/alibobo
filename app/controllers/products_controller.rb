class ProductsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @products = Product.all
    @category = Category.new

    if params[:query].present?
      sql_subquery = <<~SQL
        products.title ILIKE :query
        OR products.description ILIKE :query
        OR categories.name ILIKE :query
      SQL
      @products = @products.joins(:category).where(sql_subquery, query: "%#{params[:query]}%")
    end

    if params[:category].present?
      @products = @products.joins(:category).where("name ILIKE ?", "%#{params[:category]}%")
    end

    if params[:max_price].present?
      min_price = 0
      max_price = params[:max_price].to_i
      @products = @products.where(price: min_price..max_price)
    end

  end

  def show
    @product = Product.find(params[:id])
    @reviews = @product.reviews
    @users = User.all
    @booking = Booking.new
    @review = Review.new
    @bookings = @product.bookings

    @booking_dates = @bookings.map do |booking|
      {
        from: booking.start_date,
        to: booking.end_date
      }
    end

  end

  def new
    @product = Product.new
  end

  def myProducts
    # @products = current_user.products
    @products = Product.where(user: current_user)
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user

    if @product.save
      redirect_to product_path(@product)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy

    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:title, :price, :category_id, :description, photos: [])
  end
end
