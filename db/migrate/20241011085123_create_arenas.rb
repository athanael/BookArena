class CreateArenas < ActiveRecord::Migration[7.1]
  def change
    create_table :arenas do |t|
      t.references :users, null: false, foreign_key: true
      t.string :name
      t.integer :capacity
      t.string :address
      t.float :price

      t.timestamps
    end
  end
end
