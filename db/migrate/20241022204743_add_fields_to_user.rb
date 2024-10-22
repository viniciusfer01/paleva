class AddFieldsToUser < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :cpf, :string, :null => false
    add_column :users, :name, :string, :null => false
    add_column :users, :last_name, :string, :null => false
  end
end
