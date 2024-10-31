require 'rails_helper'

describe 'User informs new dish status' do 
  it 'and its not authenticated' do 
    
  end

  it 'and dish is set not visible' do 
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
    email: 'zezin@teclados.com', password: 'passwordpass')

    store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
    cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
    email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

    dish = Dish.create!(name: 'Pizza', description: 'Prato Italiano, que serve 3 a 4 pessoas', calories: 1200, store: store)
    Dish.create!(name: 'Feijoada', description: 'Comida típica da cozinha Brasileira, serve 3 a 4 pessoas', calories: 1500, store: store)

    login_as user 
    visit root_path
    click_on 'Meus pratos'
    click_on dish.name
    click_on 'Desativar Prato'
    
    expect(current_path).to eq dish_path(dish)
    expect(page).to have_content 'Status do Prato atualizado com sucesso.'
    expect(page).to have_content 'Status do Prato: Inativo'
  end

  it 'and dish is set visible' do 
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
    email: 'zezin@teclados.com', password: 'passwordpass')

    store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
    cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
    email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

    dish = Dish.create!(name: 'Pizza', description: 'Prato Italiano, que serve 3 a 4 pessoas', calories: 1200, store: store, status: 'inactive')
    Dish.create!(name: 'Feijoada', description: 'Comida típica da cozinha Brasileira, serve 3 a 4 pessoas', calories: 1500, store: store)

    login_as user 
    visit root_path
    click_on 'Meus pratos'
    click_on dish.name
    click_on 'Ativar Prato'

    expect(current_path).to eq dish_path(dish)
    expect(page).to have_content 'Status do Prato atualizado com sucesso.'
    expect(page).to have_content 'Status do Prato: Ativo'
  end

  it 'and doesnt see the other toggle status button' do 
    
  end
end