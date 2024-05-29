class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy

  has_many_attached :photos

  validates :title, :price, :category, :description, presence: true

  def rating
    reviews.average(:rating)&.round || 0
  end
end
