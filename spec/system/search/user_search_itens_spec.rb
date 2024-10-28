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

  it 'and finds an item by name' do
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

  it 'and finds an item by description' do
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
    email: 'zezin@teclados.com', password: 'passwordpass')

    store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                      cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                      email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

    Dish.create!(name: 'Pizza', description: 'Prato Italiano, que serve 3 a 4 pessoas', calories: 1200, store: store)
    Dish.create!(name: 'Feijoada', description: 'Comida típica da cozinha Brasileira, serve 3 a 4 pessoas', calories: 1500, store: store)

    login_as user
    visit root_path
    fill_in "Buscar item",	with: "cozinha Brasileira" 
    click_on 'Buscar'

    expect(page).to have_content 'Resultados da busca por: cozinha Brasileira'   
    expect(page).to have_content '1 item(s) encontrado(s)' 
    expect(page).to have_content 'Nome: Feijoada' 
    expect(page).to have_content 'Descrição: Comida típica da cozinha Brasileira'  
  end

  it 'and finds 2 itens' do
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
    email: 'zezin@teclados.com', password: 'passwordpass')

    store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                      cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                      email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

    Beverage.create!(name: 'Refrigerante Guaraná', description: 'Refrigerante da cozinha Brasileira, feito com uma fruta típica brasileira', 
                                calories: 1200, is_alcoholic: false, store: store)
    Dish.create!(name: 'Pizza', description: 'Prato Italiano, que serve 3 a 4 pessoas', calories: 1200, store: store)
    Dish.create!(name: 'Feijoada', description: 'Comida típica da cozinha Brasileira, serve 3 a 4 pessoas', calories: 1500, store: store)

    login_as user
    visit root_path
    fill_in "Buscar item",	with: "cozinha Brasileira" 
    click_on 'Buscar'

    expect(page).to have_content 'Resultados da busca por: cozinha Brasileira'   
    expect(page).to have_content '2 item(s) encontrado(s)' 
    expect(page).to have_content 'Nome: Feijoada' 
    expect(page).to have_content 'Descrição: Comida típica da cozinha Brasileira'  
    expect(page).to have_content 'Nome: Refrigerante Guaraná' 
    expect(page).to have_content 'Descrição: Refrigerante da cozinha Brasileira, feito com uma fruta típica brasileira'  
  end

  it 'and doesnt find any items' do
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
    email: 'zezin@teclados.com', password: 'passwordpass')

    store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                      cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                      email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

    Beverage.create!(name: 'Refrigerante Guaraná', description: 'Refrigerante da cozinha Brasileira, feito com uma fruta típica brasileira', 
                                calories: 1200, is_alcoholic: false, store: store)
    Dish.create!(name: 'Pizza', description: 'Prato Italiano, que serve 3 a 4 pessoas', calories: 1200, store: store)
    Dish.create!(name: 'Feijoada', description: 'Comida típica da cozinha Brasileira, serve 3 a 4 pessoas', calories: 1500, store: store)

    login_as user
    visit root_path
    fill_in "Buscar item",	with: "batata" 
    click_on 'Buscar'

    expect(page).to have_content 'Resultados da busca por: batata'   
    expect(page).not_to have_content '2 item(s) encontrado(s)' 
    expect(page).not_to have_content 'Nome: Feijoada' 
    expect(page).not_to have_content 'Descrição: Comida típica da cozinha Brasileira'  
    expect(page).not_to have_content 'Nome: Refrigerante Guaraná' 
    expect(page).not_to have_content 'Descrição: Refrigerante da cozinha Brasileira, feito com uma fruta típica brasileira'
    expect(page).to have_content 'Não houveram pratos encontrados.'    
    expect(page).to have_content 'Não houveram bebidas encontradas.'   
    expect(page).to have_content '0 item(s) encontrado(s)'   
  end

  it 'and finds an item by name and see its details' do
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
    click_on "#{beverage.name}"

    expect(current_path).to eq beverage_path(beverage)  
  end

  it 'finds an item by description, and edits it' do
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
    email: 'zezin@teclados.com', password: 'passwordpass')

    store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                      cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                      email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

    dish = Dish.create!(name: 'Pizza', description: 'Prato Italiano, que serve 3 a 4 pessoas', calories: 1200, store: store)

    login_as user
    visit root_path
    fill_in "Buscar item",	with: "Italiano" 
    click_on 'Buscar'
    click_on 'Editar'

    expect(current_path).to eq edit_dish_path(dish)  
  end

  it "user searches for a dish that isn't theirs" do 
    
  end
end