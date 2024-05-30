class ReviewsController < ApplicationController
  before_action :set_product

  def create
    @review = Review.new(review_params)
    @review = @product.reviews.new(review_params)
    @review.user = current_user

    if @product.reviews.exists?(user_id: current_user.id)
      flash[:alert] = "Vous avez déjà commenté ce produit."
      redirect_to @product
    else
      if @review.save
        flash[:notice] = "Votre commentaire a été ajouté avec succès."
        redirect_to @product
      else
        flash[:alert] = "Erreur lors de l'ajout de votre commentaire."
        render 'products/show'
      end
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
