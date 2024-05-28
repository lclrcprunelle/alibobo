class Booking < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validate :minimum_24h
  validate :not_in_past

  def minimum_24h
    errors.add(:base, "must last more than 24h") if end_date < start_date + 24.hours
  end

  def not_in_past
    errors.add(:base, "can't be in past") if start_date < Date.today && end_date < Date.today
  end
end
