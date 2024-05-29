class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :bookings, dependent: :destroy

  has_one_attached :photo

  validates :title, :price, :category, :description, :rating, presence: true
end
