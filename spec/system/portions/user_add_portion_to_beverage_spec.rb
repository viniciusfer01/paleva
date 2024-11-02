require 'rails_helper'

describe "User adds a portion to beverage" do
  it "succesfully" do
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                        email: 'zezin@teclados.com', password: 'passwordpass')

    store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                  cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                  email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

    beverage = Beverage.create!(name: 'YoPro', description: 'Bebida para o público fit sabor chocolate', 
                                calories: 99, is_alcoholic: false, store: store)
    Beverage.create!(name: 'Cerveja Bacon beer', description: 'Cerveja de bacon ultra fat', 
                     calories: 1500, is_alcoholic: true, store: store, status: 'inactive')
    
    login_as user
    visit root_path
    click_on 'Minhas Bebidas'
    click_on 'YoPro'
    click_on 'Adicionar Porções'
    fill_in "Descrição",	with: "Unidade (250ml)"
    fill_in "Preço",	with: 560
    click_on 'Gravar'

    expect(page).to have_content 'Descrição: Unidade (250ml)'
    expect(current_path).to eq beverage_path(beverage) 
    expect(page).to have_content 'Porção cadastrada com sucesso'
    expect(page).to have_content 'Preço: R$ 5,60'
  end 
end