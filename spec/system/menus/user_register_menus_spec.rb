require 'rails_helper'

describe 'User registers menus' do 
  it 'and is not authenticated' do 
    visit root_path

    expect(page).not_to have_content 'Novo Cardápio'    
  end

  it "succesfully" do
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                        email: 'zezin@teclados.com', password: 'passwordpass')

    Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                  cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                  email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

    login_as user
    visit root_path
    click_on 'Novo Cardápio'
    fill_in "Nome",	with: "Almoço" 
    click_on 'Salvar'
    
    expect(page).to have_content 'Cardápio cadastrado com sucesso.'    
    expect(page).to have_content 'Cardápio: Almoço'    
  end

  it 'Misses fields' do 
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                        email: 'zezin@teclados.com', password: 'passwordpass')

    Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                  cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                  email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)
    
    login_as user
    visit root_path
    click_on 'Novo Cardápio'
    click_on 'Salvar'

    expect(page).to have_content 'Não foi possível salvar o cardápio.'    
    expect(page).not_to have_content 'Cardápio cadastrado com sucesso.'    
  end
end