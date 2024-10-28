require 'rails_helper'

describe 'User searches for dish' do
  it 'from the menu' do
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
    email: 'zezin@teclados.com', password: 'passwordpass')

    Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                      cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                      email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

    login_as user
    visit root_path

    within('header nav') do 
      expect(page).to have_field('Buscar item') 
      expect(page).to have_button('Buscar') 
    end
    
  end

  it 'but is not authenticated' do
    visit root_path

    within('header nav') do 
      expect(page).not_to have_field('Buscar item') 
      expect(page).not_to have_button('Buscar') 
    end
  end

  it 'and finds an item' do
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
    email: 'zezin@teclados.com', password: 'passwordpass')

    store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                      cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                      email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

    beverage = Beverage.create!(name: 'Refrigerante Guaraná', description: 'Refrigerante feito com uma fruta típica brasileira', 
                                calories: 1200, is_alcoholic: false, store: store)

    login_as user
    visit root_path
    fill_in "Buscar item",	with: "#{beverage.name}" 
    click_on 'Buscar'

    expect(page).to have_content "Resultados da busca por: #{beverage.name}"   
    expect(page).to have_content '1 item(s) encontrado(s)' 
    expect(page).to have_content "Nome: #{beverage.name}" 
    expect(page).to have_content "Descrição: #{beverage.description}"  
  end
end