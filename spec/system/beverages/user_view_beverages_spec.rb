require 'rails_helper'

describe "User sees the beverages" do
  it "succesfully" do
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                        email: 'zezin@teclados.com', password: 'passwordpass')

    store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                  cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                  email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

    Beverage.create!(name: 'YoPro', description: 'Bebida para o público fit sabor chocolate', calories: 99, is_alcoholic: false, store: store)
    Beverage.create!(name: 'Cerveja Bacon beer', description: 'Cerveja de bacon ultra fat', 
                     calories: 1500, is_alcoholic: true, store: store, status: 'inactive')
    
    login_as user
    visit root_path
    click_on 'Minhas Bebidas'

    expect(page).to have_content 'Bebidas do estabelecimento:'
    expect(page).to have_content 'Nome: YoPro'  
    expect(page).to have_content '99 kcal'  
    expect(page).to have_content 'Status da Bebida: Ativo'  
    expect(page).to have_content 'Cerveja Bacon beer'  
    expect(page).to have_content '1500 kcal'  
    expect(page).to have_content 'true'  
    expect(page).to have_content 'Status da Bebida: Inativo'  
  end

  it "fails because there aren't any beverages" do
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                        email: 'zezin@teclados.com', password: 'passwordpass')

    Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                          cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                          email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

    login_as user
    visit root_path
    click_on 'Minhas Bebidas'                          
    
    expect(page).to have_content 'Ainda não há Bebidas cadastradas...'
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
    
    Beverage.create!(name: 'YoPro', description: 'Bebida para o público fit sabor chocolate', calories: 99, is_alcoholic: false, store: store)
    
    login_as first_user
    visit root_path
    click_on 'Minhas Bebidas'
    
    expect(page).not_to have_content 'Prato: YoPro'  
    expect(page).not_to have_content 'Descrição: Bebida para o público fit sabor chocolate'  
    expect(page).not_to have_content '99 kcal'
    expect(page).to have_content 'Ainda não há Bebidas cadastradas...'
  end
end
