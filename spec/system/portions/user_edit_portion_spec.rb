require 'rails_helper'

describe "User edits a portion" do
  it "that is a dish succesfully" do
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                        email: 'zezin@teclados.com', password: 'passwordpass')

    store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                  cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                  email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

    dish = Dish.create!(name: 'Pizza', description: 'Prato Italiano, que serve 3 a 4 pessoas', calories: 1200, store: store)

    dish.portions.create!(description: 'Grande (12 fatias)', price: 120_00)
    
    login_as user
    visit root_path
    click_on 'Meus pratos'
    click_on 'Pizza'
    click_on 'Grande (12 fatias)'
    fill_in "Descrição",	with: "Pequena (4 fatias)"
    fill_in "Preço",	with: 45_00
    click_on 'Gravar'
    
    expect(page).to have_content 'Preço: R$ 45,00'
    expect(page).to have_content 'Descrição: Pequena (4 fatias)'
    expect(current_path).to eq dish_path(dish) 
    expect(page).to have_content 'Porção atualizada com sucesso'
  end 

  it "that is a beverage succesfully" do
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                        email: 'zezin@teclados.com', password: 'passwordpass')

    store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                  cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                  email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

    beverage = Beverage.create!(name: 'YoPro', description: 'Bebida para o público fit sabor chocolate', 
                                calories: 99, is_alcoholic: false, store: store)

    beverage.portions.create!(description: 'Litro', price: 20_00)
    
    login_as user
    visit root_path
    click_on 'Minhas Bebidas'
    click_on 'YoPro'
    click_on 'Litro'
    fill_in "Descrição",	with: "Unidade (250ml)"
    fill_in "Preço",	with: 5_60
    click_on 'Gravar'
    
    expect(page).to have_content 'Preço: R$ 5,60'
    expect(page).to have_content 'Descrição: Unidade (250ml)'
    expect(current_path).to eq beverage_path(beverage) 
    expect(page).to have_content 'Porção atualizada com sucesso'
  end 
end