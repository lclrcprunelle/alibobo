class Product < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy

  has_many_attached :photos

  validates :title, :price, :category, :description, :rating, presence: true
end
