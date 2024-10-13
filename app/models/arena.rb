class Arena < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  validates :name, presence: true
  validates :name, length: { minimum: 2 }
  validates :capacity, presence: true
  validates :address, presence: true
  validates :address, uniqueness: true
  validates :price, presence: true
  validates :description, presence: true
  validates :description, length: { in: 10..500 }
  has_one_attached :photo
end
