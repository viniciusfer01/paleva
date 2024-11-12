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
    
    dish = Dish.create!(name: 'Feijoada', description: 'Feijoada completa', store: store)
    beverage = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante de cola',
                                is_alcoholic: false, store: store)

    Portion.create!(description: 'Porção grande', price: 3000, dish: dish)
    Portion.create!(description: 'Lata 350ml', price: 500, beverage: beverage)
    
    allow(SecureRandom).to receive(:alphanumeric).and_return('A123456B')

    login_as user 
    visit root_path
    click_on 'Almoço'
    click_on 'Novo Pedido'
    fill_in 'Telefone', with: '99999999998'
    fill_in 'CPF', with: '66101052001'
    
    within('.order_dish') do
      fill_in 'Observação sobre o prato', with: 'Sem cebola'
    end

    within('.order_beverage') do
      fill_in 'Observação sobre a bebida', with: 'Bem gelada'
    end

    click_on 'Gravar Pedido'

    expect(page).to have_content 'Pedido gravado com sucesso' 
    expect(page).to have_content "Pedido: A123456B"
    expect(page).to have_content 'Dados do cliente:' 
    expect(page).to have_content 'Nome: Zezin' 
    expect(page).to have_content 'Telefone: 99999999998' 
    expect(page).to have_content 'Email: zezin@teclados.com' 
    expect(page).to have_content 'CPF: 66101052001' 
    expect(page).to have_content 'Status do Pedido: Aguardando confirmação da cozinha' 
    expect(page).to have_content 'Feijoada - Porção grande'
    expect(page).to have_content 'Observação: Sem cebola'
    expect(page).to have_content 'Coca-Cola - Lata 350ml'
    expect(page).to have_content 'Observação: Bem gelada'
    expect(page).to have_content 'Valor Total: R$ 35,00'
  end
end