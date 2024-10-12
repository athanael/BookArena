class ChangeUsersIdToArenas < ActiveRecord::Migration[7.1]
  def change
    rename_column :arenas, :users_id, :user_id
  end
end
