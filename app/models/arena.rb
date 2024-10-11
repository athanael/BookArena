class Arena < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :name, length: { minimum: 2 }
  validates :capacity, presence: true
  validates :address, presence: true
  validates :address, uniqueness: true
  validates :price, presence: true
  has_many_attached :photo
end
