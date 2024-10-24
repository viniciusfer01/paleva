class CreateStores < ActiveRecord::Migration[7.2]
  def change
    create_table :stores do |t|
      t.string :brand_name, null: false
      t.string :corporate_name, null: false
      t.string :cnpj, null: false
      t.string :address, null: false
      t.string :phone, null: false
      t.string :email, null: false
      t.string :schedule, null: false
      t.string :code, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
