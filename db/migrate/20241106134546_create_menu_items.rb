class CreateMenuItems < ActiveRecord::Migration[7.2]
  def change
    create_table :menu_items do |t|
      t.references :menu, null: false, foreign_key: true
      t.references :dish, foreign_key: true, null: true
      t.references :beverage, foreign_key: true, null: true

      t.timestamps
    end
  end
end
