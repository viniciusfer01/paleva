require 'rails_helper'

describe 'Employee sees an order' do 
  it 'created by an user' do 
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                        email: 'zezin@teclados.com', password: 'passwordpass')

    store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                  cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                  email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

    store.menus.create!(name: 'Almoço')                  
    store.menus.create!(name: 'Jantar')   
    
    dish = store.dishes.create!(name: 'Feijoada', description: 'Feijoada completa', store: store)
    beverage = store.beverages.create!(name: 'Coca-Cola', description: 'Refrigerante de cola',
                                is_alcoholic: false, store: store)

    dish.portions.create!(description: 'Porção grande', price: 3000, dish: dish)
    beverage.portions.create!(description: 'Lata 350ml', price: 500, beverage: beverage)
    
    allow(SecureRandom).to receive(:alphanumeric).and_return('A123456B')

    store.orders.create!(name: user.name, phone: '99999999999', email: user.email,
                         cpf: user.cpf, price: 3500, user: user, store: store)

    order = Order.create!(name: user.name, phone: '99999999999', email: user.email,
                      cpf: user.cpf, price: 3500, user: user, store: store)

    order.order_items.create!(order: order, portion: dish.portions.first, note: 'Bem quente')
    order.order_items.create!(order: order, portion: beverage.portions.first, note: 'Bem gelada')

    store.pre_registered_employees.create!(cpf: '37739673064', email: 'tiringa@email.com')

    emp = store.employees.create!(cpf: '37739673064', name: 'Tiringa', last_name: 'da Silva', 
                        email: 'tiringa@teclados.com', password: 'passwordpass', store: store)

    login_as(emp, scope: :employee)
    visit root_path
    click_on 'Meus Pedidos'

    expect(page).to have_content "A123456B"
    expect(page).to have_content 'Status do Pedido: Aguardando confirmação da cozinha' 
    expect(page).to have_content 'Feijoada - Porção grande'
    expect(page).to have_content 'Observação: Bem quente'
    expect(page).to have_content 'Coca-Cola - Lata 350ml'
    expect(page).to have_content 'Observação: Bem gelada'
    expect(page).to have_content 'Valor Total: R$ 35,00'
  end
end