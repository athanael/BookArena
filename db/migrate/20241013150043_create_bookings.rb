class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.date :start
      t.date :end
      t.float :total
      t.references :user, null: false, foreign_key: true
      t.references :arena, null: false, foreign_key: true
      t.text :status

      t.timestamps
    end
  end
end
