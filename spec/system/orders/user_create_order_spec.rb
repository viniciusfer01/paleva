require 'rails_helper'

describe 'User creates an order' do 
  it 'succesfully' do 
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                        email: 'zezin@teclados.com', password: 'passwordpass')

    store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                  cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                  email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

    store.menus.create!(name: 'Almoço')                  
    store.menus.create!(name: 'Jantar')   
    
    allow(SecureRandom).to receive(:alphanumeric).and_return('A123456B')

    login_as user 
    visit root_path
    click_on 'Almoço'
    click_on 'Novo Pedido'
    fill_in 'Telefone', with: '99999999998'
    click_on 'Iniciar Pedido'

    expect(page).to have_content 'Pedido iniciado com sucesso' 
    expect(page).to have_content "Pedido: A123456B"
    expect(page).to have_content 'Dados do cliente:' 
    expect(page).to have_content 'Nome: Zezin' 
    expect(page).to have_content 'Telefone: 99999999998' 
    expect(page).to have_content 'Email: zezin@teclados.com' 
    expect(page).to have_content 'CPF: 66101052001' 
    expect(page).to have_content 'Status do Pedido: Iniciado' 
  end
end