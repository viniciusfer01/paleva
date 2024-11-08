class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.string :name, null: false
      t.string :phone
      t.string :email
      t.string :cpf
      t.integer :status, default: 0
      t.string :code, null: false
      t.integer :price, null: false
      t.references :user, foreign_key: true
      t.references :store, foreign_key: true

      t.timestamps
    end
  end
end
