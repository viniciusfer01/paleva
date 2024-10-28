require 'rails_helper'

describe "User removes beverage" do
  it "succesfully" do
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
    email: 'zezin@teclados.com', password: 'passwordpass')

    store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                  cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                  email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

    Beverage.create!(name: 'Suco de manga', description: 'Suco de frutas natural', is_alcoholic: false, calories: 140, store: store)

    login_as user
    visit root_path
    click_on 'Minhas Bebidas'
    click_on 'Suco de manga'
    click_on 'Deletar'    

    expect(page).to have_content 'Bebidas do estabelecimento:' 
    expect(page).to have_content 'Bebida deletada com sucesso' 
    expect(page).not_to have_content 'Suco de manga' 
  end
end
