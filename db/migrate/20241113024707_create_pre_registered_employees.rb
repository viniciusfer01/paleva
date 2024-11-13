class CreatePreRegisteredEmployees < ActiveRecord::Migration[7.2]
  def change
    create_table :pre_registered_employees do |t|
      t.string :email, null: false
      t.string :cpf, null: false
      t.boolean :used, null: false, default: false
      t.references :store, null: false, foreign_key: true

      t.timestamps
    end
  end
end
