class Arena < ApplicationRecord
  belongs_to :users
  validates :name, presence: true
  validates :name, length: { minimum: 2 }
  validates :capacity, presence: true
  validates :address, presence: true
  validates :address, uniqueness: true
  validates :price, presence: true
end
