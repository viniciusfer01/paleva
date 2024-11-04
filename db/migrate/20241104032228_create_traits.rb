class CreateTraits < ActiveRecord::Migration[7.2]
  def change
    create_table :traits do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :traits, :name, unique: true
  end
end
