class ReviewsController < ApplicationController
  before_action :set_product

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.product = @product

    if @review.save
      redirect_to product_path(@product), notice: "Review successfully added"
    else
      render "products/show", status: :unprocessable_entity
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def review_params
    params.require(:review).permit(:description, :rating)
  end
end
