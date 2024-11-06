require 'rails_helper'

describe 'User registers menus' do 
  it 'and is not authenticated' do 
  end

  it "succesfully" do
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                        email: 'zezin@teclados.com', password: 'passwordpass')

    store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                  cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                  email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

    Dish.create!(name: 'Pizza', description: 'Prato Italiano, que serve 3 a 4 pessoas', calories: 1200, store: store)
    Dish.create!(name: 'Feijoada', description: 'Comida típica da cozinha Brasileira, serve 3 a 4 pessoas', 
                 calories: 1500, store: store)
    
    login_as user
    visit root_path
    click_on 'Novo Cardápio'
    fill_in "Nome",	with: "Almoço" 
    click_on 'Salvar'
    
    expect(page).to have_content 'Cardápio cadastrado com sucesso.'    
    expect(page).to have_content 'Cardápio: Almoço'    
  end

  it 'Misses fields' do 
  end
end