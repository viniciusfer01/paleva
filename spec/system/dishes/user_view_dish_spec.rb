require 'rails_helper'

describe "User views their dish" do  
  it "succesfully" do
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
    email: 'zezin@teclados.com', password: 'passwordpass')
    
    store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
    cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
    email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)
    
    Dish.create!(name: 'Pizza', description: 'Prato Italiano, que serve 3 a 4 pessoas', calories: 1200, store: store)
    
    login_as user
    visit root_path
    click_on 'Meus pratos'
    click_on 'Pizza'    
    
    expect(page).to have_content 'Prato: Pizza'  
    expect(page).to have_content 'Descrição: Prato Italiano, que serve 3 a 4 pessoas'  
    expect(page).to have_content '1200 kcal'  
  end

  it "but fails, because the user doesn't own the store" do
    first_user = User.create!(cpf: '96287760028', name: 'Geraldo', last_name: 'Antunes', 
    email: 'geraldo@refrigeracao.com', password: 'passwordpass')
    second_user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
    email: 'zezin@teclados.com', password: 'passwordpass')
    
    store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
    cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
    email: 'pasteis@zezin.com', schedule: '23456M123456', user: second_user)

    Store.create!(corporate_name: 'Zezin Alimentos2 LTDA', brand_name: 'Pastéis Zezin2', 
    cnpj: '66345931000130', address: 'Rua das tulipas, 180', phone: '2345123426', 
    email: 'pasteis2@zezin.com', schedule: '23456M12346', user: first_user)
    
    dish = Dish.create!(name: 'Pizza', description: 'Prato Italiano, que serve 3 a 4 pessoas', calories: 1200, store: store)
    
    login_as first_user
    visit dish_path dish
    
    expect(page).not_to have_content 'Prato: Pizza'  
    expect(page).not_to have_content 'Descrição: Prato Italiano, que serve 3 a 4 pessoas'  
    expect(page).not_to have_content '1200 kcal'
    expect(page).to have_content 'Cardápios do Estabelecimento'
  end
end