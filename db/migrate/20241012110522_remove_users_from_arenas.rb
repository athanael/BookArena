class RemoveUsersFromArenas < ActiveRecord::Migration[7.1]
    remove_reference :arenas, :user, index: true
  def change
  end
end
