class AddUserToArena < ActiveRecord::Migration[7.1]
  def change
    add_reference :arenas, :user, foreign_key: true
  end
end
