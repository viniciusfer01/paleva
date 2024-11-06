require 'rails_helper'

describe 'User adds menu items' do 
  it 'succesfully' do 
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                        email: 'zezin@teclados.com', password: 'passwordpass')

    store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                  cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                  email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

    Dish.create!(name: 'Pizza', description: 'Prato Italiano, que serve 3 a 4 pessoas', calories: 1200, store: store)
    Dish.create!(name: 'Feijoada', description: 'Comida típica da cozinha Brasileira, serve 3 a 4 pessoas', 
                  calories: 1500, store: store, status: 'inactive')
    Beverage.create!(name: 'Guaraná', description: 'Refrigerante de guaraná', 
                     calories: 199, is_alcoholic: false, store: store)

    store.menus.create!(name: 'Café da Manhã')                  
    store.menus.create!(name: 'Almoço')                  
    store.menus.create!(name: 'Jantar')                  

    login_as user
    visit root_path
    click_on 'Meus Cardápios'
    click_on 'Almoço'
    click_on 'Adicionar Itens'
    select 'Pizza', from: 'Pratos'
    select 'Feijoada', from: 'Pratos'
    select 'Guaraná', from: 'Bebidas'
    click_on 'Salvar'
    
    expect(page).to have_content 'Itens cadastrados com sucesso.'    
    expect(page).to have_content 'Cardápio: Almoço'   
    expect(page).to have_content 'Almoço'    
    expect(page).to have_content 'Pizza'    
    expect(page).not_to have_content 'Feijoada'    
    expect(page).to have_content 'Guaraná'    
  end

  it 'and misses fields' do   
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                        email: 'zezin@teclados.com', password: 'passwordpass')

    store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                  cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                  email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

    Dish.create!(name: 'Pizza', description: 'Prato Italiano, que serve 3 a 4 pessoas', calories: 1200, store: store)
    Dish.create!(name: 'Feijoada', description: 'Comida típica da cozinha Brasileira, serve 3 a 4 pessoas', 
                  calories: 1500, store: store, status: 'inactive')
    Beverage.create!(name: 'Guaraná', description: 'Refrigerante de guaraná', 
                     calories: 199, is_alcoholic: false, store: store)

    store.menus.create!(name: 'Café da Manhã')                  
    store.menus.create!(name: 'Almoço')                  
    store.menus.create!(name: 'Jantar')                  

    login_as user
    visit root_path
    click_on 'Meus Cardápios'
    click_on 'Almoço'
    click_on 'Adicionar Itens'
    click_on 'Salvar'
    
    expect(page).not_to have_content 'Itens cadastrados com sucesso.'    
    expect(page).to have_content 'Não foi possível cadastrar os itens'   
    expect(page).to have_content 'Não há pratos cadastrados'   
    expect(page).to have_content 'Não há bebidas cadastradas'   
  end
end