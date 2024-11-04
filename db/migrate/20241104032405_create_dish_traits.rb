class CreateDishTraits < ActiveRecord::Migration[7.2]
  def change
    create_table :dish_traits do |t|
      t.references :dish, null: false, foreign_key: true
      t.references :trait, null: false, foreign_key: true

      t.timestamps
    end
  end
end
