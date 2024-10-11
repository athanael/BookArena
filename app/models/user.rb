class User < ApplicationRecord
  has_many :arena
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  has_one_attached :photo
end
