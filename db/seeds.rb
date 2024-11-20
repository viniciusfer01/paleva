# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                        email: 'zezin@teclados.com', password: 'passwordpass')

store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
              cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
              email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

dish = store.dishes.create!(name: 'Feijoada', description: 'Feijoada completa', store: store)
beverage = store.beverages.create!(name: 'Coca-Cola', description: 'Refrigerante de cola',
                            is_alcoholic: false, store: store)

dish.portions.create!(description: 'Porção grande', price: 3000, dish: dish)
beverage.portions.create!(description: 'Lata 350ml', price: 500, beverage: beverage)

store.menus.create!(name: 'Almoço')                  
store.menus.create!(name: 'Jantar') 
  
# order = Order.create!(name: user.name, phone: '99999999999', email: user.email,
#                       cpf: user.cpf, price: 3500, user: user, store: store)

# order.order_items.create!(order: order, portion: first_portion, note: 'Bem quente')
# order.order_items.create!(order: order, portion: second_portion, note: 'Bem gelada')
