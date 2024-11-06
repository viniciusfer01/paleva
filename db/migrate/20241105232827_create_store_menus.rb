class CreateStoreMenus < ActiveRecord::Migration[7.2]
  def change
    create_table :store_menus do |t|
      t.references :store, null: false, foreign_key: true
      t.references :menu, null: false, foreign_key: true

      t.timestamps
    end
  end
end
