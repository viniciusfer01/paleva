class CreatePortions < ActiveRecord::Migration[7.2]
  def change
    create_table :portions do |t|
      t.string :description
      t.integer :price
      t.references :beverage, foreign_key: true
      t.references :dish, foreign_key: true

      t.timestamps
    end
  end
end
