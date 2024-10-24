class CreateDishes < ActiveRecord::Migration[7.2]
  def change
    create_table :dishes do |t|
      t.string :name
      t.string :description
      t.integer :calories
      t.references :store, null: false, foreign_key: true

      t.timestamps
    end
  end
end
