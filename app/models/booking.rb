class Booking < ApplicationRecord
  has_one :user
  belongs_to :arena

  validates :start, presence: true
  validates :end, presence: true
  validates :total, presence: true
  validates :status, presence: true
  validates :status, inclusion: { in: ['pending', 'accepted', 'declined'] }
end