require 'rails_helper'

describe "User removes dish" do
  it "succesfully" do
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
    email: 'zezin@teclados.com', password: 'passwordpass')

    store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                  cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                  email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

    Dish.create!(name: 'Pizza', description: 'Prato Italiano, que serve 3 a 4 pessoas', calories: 1200, store: store)

    login_as user
    visit root_path
    click_on 'Meus pratos'
    click_on 'Pizza'
    click_on 'Deletar'    

    expect(page).to have_content 'Pratos do estabelecimento:' 
    expect(page).to have_content 'Prato deletado com sucesso' 
    expect(page).not_to have_content 'Pizza' 
  end
end
