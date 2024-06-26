class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :products, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :reserved_products, through: :bookings, source: :product

  has_many :bookings_as_owner, through: :products, source: :bookings
  has_many :bookings_as_lodger, class_name: "Booking", foreign_key: "user_id", dependent: :destroy

  has_one_attached :photo

  def full_name
    "#{first_name} #{last_name}"
  end
end
