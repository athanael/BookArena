class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :bookings, dependent: :destroy
  has_one_attached :photo
  has_one :arena

  # Validations
  validates :first_name, :last_name, presence: true
  validates :category, inclusion: { in: ['band', 'owner', 'admin'] }
end
