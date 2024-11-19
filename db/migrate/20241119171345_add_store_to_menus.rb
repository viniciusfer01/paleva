class AddStoreToMenus < ActiveRecord::Migration[7.2]
  def change
    add_reference :menus, :store, foreign_key: true
  end
end
