require 'rails_helper'

describe "User sets an order status" do
  it "if is authenticated" do
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
    email: 'zezin@teclados.com', password: 'passwordpass')

    store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
    cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
    email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

    dish = Dish.create!(name: 'Pizza', description: 'Prato Italiano, que serve 3 a 4 pessoas', calories: 1200, store: store, status: 'inactive')
    Dish.create!(name: 'Feijoada', description: 'Comida típica da cozinha Brasileira, serve 3 a 4 pessoas', calories: 1500, store: store)

    post(inactive_dish_path(dish))
    expect(response).to redirect_to new_user_session_path  
  end

  it "if is responsable" do
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
    email: 'zezin@teclados.com', password: 'passwordpass')

    user2 = User.create!(cpf: '37968480019', name: 'Rogerin', last_name: 'do Teclados', 
    email: 'rogerin@teclados.com', password: 'passwordpass')

    store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
    cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
    email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

    dish = Dish.create!(name: 'Pizza', description: 'Prato Italiano, que serve 3 a 4 pessoas', calories: 1200, store: store, status: 'inactive')
    Dish.create!(name: 'Feijoada', description: 'Comida típica da cozinha Brasileira, serve 3 a 4 pessoas', calories: 1500, store: store)

    login_as user2
    post(inactive_dish_path(dish))
    expect(response).to redirect_to new_store_path  
  end

  it 'if is a beverage' do 
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
    email: 'zezin@teclados.com', password: 'passwordpass')

    store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
    cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
    email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

    beverage = Beverage.create!(name: 'YoPro', description: 'Bebida para o público fit sabor chocolate', calories: 99, 
                                is_alcoholic: false, store: store, status: 'inactive')
    Beverage.create!(name: 'Cerveja Bacon beer', description: 'Cerveja de bacon ultra fat', calories: 1500, is_alcoholic: true, store: store)

    post(inactive_beverage_path(beverage))
    expect(response).to redirect_to new_user_session_path  
  end
end
