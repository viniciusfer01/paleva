require 'rails_helper'

describe 'User informs new beverage status' do 
  it 'and beverage is set not visible' do 
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
    email: 'zezin@teclados.com', password: 'passwordpass')

    store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
    cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
    email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

    beverage = Beverage.create!(name: 'YoPro', description: 'Bebida para o público fit sabor chocolate', calories: 99, is_alcoholic: false, store: store)
    Beverage.create!(name: 'Cerveja Bacon beer', description: 'Cerveja de bacon ultra fat', calories: 1500, is_alcoholic: true, store: store)

    login_as user 
    visit root_path
    click_on 'Minhas Bebidas'
    click_on beverage.name
    click_on 'Desativar Bebida'
    
    expect(current_path).to eq beverage_path(beverage)
    expect(page).to have_content 'Status da Bebida atualizado com sucesso.'
    expect(page).to have_content 'Status da Bebida: Inativo'
    expect(page).not_to have_content 'Desativar Bebida' 
    expect(page).to have_content 'Ativar Bebida'  
  end

  it 'and beverage is set visible' do 
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
    email: 'zezin@teclados.com', password: 'passwordpass')

    store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
    cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
    email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

    beverage = Beverage.create!(name: 'YoPro', description: 'Bebida para o público fit sabor chocolate', calories: 99, 
                                is_alcoholic: false, store: store, status: 'inactive')
    Beverage.create!(name: 'Cerveja Bacon beer', description: 'Cerveja de bacon ultra fat', calories: 1500, is_alcoholic: true, store: store)

    login_as user 
    visit root_path
    click_on 'Minhas Bebidas'
    click_on beverage.name
    click_on 'Ativar Bebida'

    expect(current_path).to eq beverage_path(beverage)
    expect(page).to have_content 'Status da Bebida atualizado com sucesso.'
    expect(page).to have_content 'Status da Bebida: Ativo'
    expect(page).not_to have_content 'Ativar Bebida' 
    expect(page).to have_content 'Desativar Bebida' 
  end
end