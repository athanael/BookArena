class AddStartAndEndToBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :bookings, :start, :datetime unless column_exists?(:bookings, :start)
    add_column :bookings, :end, :datetime unless column_exists?(:bookings, :end)
  end
end
