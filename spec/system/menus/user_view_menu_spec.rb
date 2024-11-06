require 'rails_helper'

describe "User sees menu items" do
  it "succesfully" do
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                        email: 'zezin@teclados.com', password: 'passwordpass')

    store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                  cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                  email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

    store.menus.create!(name: 'Café da Manhã')                  
    menu = store.menus.create!(name: 'Almoço')                  
    store.menus.create!(name: 'Jantar')     
    dish = menu.dishes.create!(name: 'Pizza', description: 'Prato Italiano, que serve 3 a 4 pessoas', calories: 1200, store: store)
    beverage = menu.beverages.create!(name: 'YoPro', description: 'Bebida para o público fit sabor chocolate', calories: 99, is_alcoholic: false, store: store)
    
    dish.portions.create!(description: 'Grande (8 fatias)', price: 8000)
    dish.portions.create!(description: 'Gigante (12 fatias)', price: 9000)
    beverage.portions.create!(description: 'Unidade', price: 560)
    beverage.portions.create!(description: 'Caixa (12 unidades)', price: 5600)


    login_as user
    visit root_path
    click_on 'Meus Cardápios'
    click_on 'Almoço'

    expect(page).to have_content 'Cardápio: Almoço'   
    expect(page).to have_content 'Porções:'    
    expect(page).to have_content 'Preço:'    
    expect(page).to have_content 'Pizza'    
    expect(page).to have_content 'Grande (8 fatias)'    
    expect(page).to have_content 'R$ 80,00'    
    expect(page).to have_content 'Gigante (12 fatias)'    
    expect(page).to have_content 'R$ 90,00'    
    expect(page).to have_content 'YoPro'    
    expect(page).to have_content 'Unidade'    
    expect(page).to have_content 'R$ 5,60'    
    expect(page).to have_content 'Caixa (12 unidades)'    
    expect(page).to have_content 'R$ 56,00'    
  end

  it 'and does not see inactive dishes' do 
    
  end
end
