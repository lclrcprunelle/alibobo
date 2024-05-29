class ProductsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @products = Product.all
    @products = Product.all
    if params[:query].present?
      @products = @products.joins(:category).where("name ILIKE ?", "%#{params[:query]}%")
    end
  end

  def show
    @booking = Booking.new
    @product = Product.find(params[:id])
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
    params.require(:product).permit(:title, :price, :category_id, :description, :rating, photos: [])
  end
end
