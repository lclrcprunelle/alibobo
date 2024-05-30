class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
    @products = Product.all
    if current_user
    @my_products = current_user.products
    inch = []
      if @products.length > 0
        @my_products.each do |product|
          product.bookings.each do |booking|
            inch << booking
          end
        end
        inch.each do |book|
          @book = book
        end
     end
    end
  end
end
