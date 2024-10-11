class AddDescriptionToArenas < ActiveRecord::Migration[7.1]
  def change
    add_column :arenas, :description, :text
  end
end
