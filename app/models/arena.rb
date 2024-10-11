class Arena < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :name, length: { minimum: 2 }
  validates :capacity, presence: true
  validates :adress, presence: true
  validates :adress, uniqueness: true
  validates :price, presence: true
  has_one_attached :photo
end
