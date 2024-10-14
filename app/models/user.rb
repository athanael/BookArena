class User < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :bookings, dependent: :destroy
  has_one_attached :photo
  has_many :arenas, dependent: :destroy

  # Validations
  validates :first_name, :last_name, presence: true
  validates :category, inclusion: { in: ['band', 'owner', 'admin'] }

  # Callback to notify owners before deleting the artist
  before_destroy :notify_owners_of_cancellation, if: :band?

  private

  # Check if user is a band
  def band?
    category == 'band'
  end

  # Send cancellation emails to all owners involved in bookings with this artist
  def notify_owners_of_cancellation
    bookings.includes(:arena).each do |booking|
      CancellationMailer.with(artist: self, arena: booking.arena).cancellation_notification.deliver_later
    end
  end
end
