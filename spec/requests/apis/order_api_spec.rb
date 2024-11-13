require 'rails_helper'

describe 'Order API' do 
  context "Get /api/orders" do
    it 'success' do 
      user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                        email: 'zezin@teclados.com', password: 'passwordpass')

      store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                    cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                    email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)
      
      dish = Dish.create!(name: 'Feijoada', description: 'Feijoada completa', store: store)
      beverage = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante de cola',
                                  is_alcoholic: false, store: store)

      first_portion = Portion.create!(description: 'Porção grande', price: 3000, dish: dish)
      second_portion = Portion.create!(description: 'Lata 350ml', price: 500, beverage: beverage)

      order = Order.create!(name: user.name, phone: '99999999999', email: user.email,
                            cpf: user.cpf, price: 3500, user: user, store: store)

      order.order_items.create!(order: order, portion: first_portion, note: 'Bem quente')
      order.order_items.create!(order: order, portion: second_portion, note: 'Bem gelada')

      get "/api/orders?code=#{store.code}"

      expect(response.status).to eq 200  
      expect(response.content_type).to include 'application/json'  
      expect(response.body).to include(order.code)  
    end

    it 'filters orders by status' do 
      first_user = User.create!(cpf: '96287760028', name: 'Geraldo', last_name: 'Antunes', 
      email: 'geraldo@refrigeracao.com', password: 'passwordpass')
      
      second_user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                        email: 'zezin@teclados.com', password: 'passwordpass')

      Store.create!(corporate_name: 'Zezin Alimentos2 LTDA', brand_name: 'Pastéis Zezin2', 
      cnpj: '66345931000130', address: 'Rua das tulipas, 180', phone: '2345123426', 
      email: 'pasteis2@zezin.com', schedule: '23456M12346', user: first_user)

      store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                    cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                    email: 'pasteis@zezin.com', schedule: '23456M123456', user: second_user)

      
      dish = Dish.create!(name: 'Feijoada', description: 'Feijoada completa', store: store)
      beverage = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante de cola',
                                  is_alcoholic: false, store: store)

      first_portion = dish.portions.create!(description: 'Porção grande', price: 3000, dish: dish)
      second_portion = beverage.portions.create!(description: 'Lata 350ml', price: 500, beverage: beverage)

      order = Order.create!(name: second_user.name, phone: '99999999999', email: second_user.email,
      cpf: second_user.cpf, price: 3500, user: second_user, store: store)
      
      second_order = Order.create!(name: second_user.name, phone: '99999999999', email: second_user.email,
      cpf: second_user.cpf, price: 9000, user: second_user, store: store, status: 'ready')
      
      other_order = Order.create!(name: first_user.name, phone: '99999999999', email: first_user.email,
                            cpf: first_user.cpf, price: 3500, user: first_user, store: store)

      order.order_items.create!(order: order, portion: first_portion, note: 'Bem quente')
      order.order_items.create!(order: order, portion: second_portion, note: 'Bem gelada')

      get "/api/orders?code=#{store.code}&status=ready"

      expect(response.status).to eq 200  
      expect(response.content_type).to include 'application/json'  
      expect(response.body).not_to include(order.code)  
      expect(response.body).not_to include(other_order.code)  
      expect(response.body).to include(second_order.code)  
    end

    context "Get /api/order" do
      it 'success' do 
        user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                          email: 'zezin@teclados.com', password: 'passwordpass')
  
        store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                      cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                      email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)
        
        dish = Dish.create!(name: 'Feijoada', description: 'Feijoada completa', store: store)
        beverage = Beverage.create!(name: 'Coca-Cola', description: 'Refrigerante de cola',
                                    is_alcoholic: false, store: store)
  
        first_portion = Portion.create!(description: 'Porção grande', price: 3000, dish: dish)
        second_portion = Portion.create!(description: 'Lata 350ml', price: 500, beverage: beverage)
  
        order = Order.create!(name: user.name, phone: '99999999999', email: user.email,
                              cpf: user.cpf, price: 3500, user: user, store: store)
  
        order.order_items.create!(order: order, portion: first_portion, note: 'Bem quente')
        order.order_items.create!(order: order, portion: second_portion, note: 'Bem gelada')
  
        get "/api/orders/#{order.code}?code=#{store.code}"
  
        expect(response.status).to eq 200  
        expect(response.content_type).to include 'application/json'  
        expect(response.body).to include(order.code)  
        expect(response.body).to include(store.code)  
        expect(response.body).to include(store.address)  
      end
    end
  end
end