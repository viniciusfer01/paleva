require 'rails_helper'

describe "User sees menus" do
  it "succesfully" do
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                        email: 'zezin@teclados.com', password: 'passwordpass')

    store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                  cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                  email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

    store.menus.create!(name: 'Café da Manhã')                  
    store.menus.create!(name: 'Almoço')                  
    store.menus.create!(name: 'Jantar')                  

    login_as user
    visit root_path
    click_on 'Meus Cardápios'
    
    expect(page).to have_content 'Cardápios do Estabelecimento'    
    expect(page).to have_content 'Café'    
    expect(page).to have_content 'Almoço'    
    expect(page).to have_content 'Jantar' 
  end

  it "but there aren't any menus" do
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                        email: 'zezin@teclados.com', password: 'passwordpass')

    Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                  cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                  email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

    login_as user
    visit root_path
    click_on 'Meus Cardápios'
    
    expect(page).to have_content 'Cardápios do Estabelecimento'    
    expect(page).to have_content 'Não há cardápios registrados...'    
  end

  it "and doesn't see other's menus" do
    first_user = User.create!(cpf: '96287760028', name: 'Geraldo', last_name: 'Antunes', 
                              email: 'geraldo@refrigeracao.com', password: 'passwordpass')

    second_user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                        email: 'zezin@teclados.com', password: 'passwordpass')
                        
    first_store = Store.create!(corporate_name: 'Zezin Alimentos2 LTDA', brand_name: 'Pastéis Zezin2', 
                  cnpj: '66345931000130', address: 'Rua das tulipas, 180', phone: '2345123426', 
                  email: 'pasteis2@zezin.com', schedule: '23456M12346', user: first_user)
    second_store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                  cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                  email: 'pasteis@zezin.com', schedule: '23456M123456', user: second_user)


    second_store.menus.create!(name: 'Café da Manhã')                  
    second_store.menus.create!(name: 'Almoço')                  
    second_store.menus.create!(name: 'Jantar')      
    first_store.menus.create!(name: 'Refeições Árabes')            

    login_as second_user
    visit root_path
    click_on 'Meus Cardápios'
    
    expect(page).to have_content 'Cardápios do Estabelecimento'    
    expect(page).to have_content 'Café'    
    expect(page).to have_content 'Almoço'    
    expect(page).to have_content 'Jantar' 
    expect(page).not_to have_content 'Refeições Árabes' 
  end
end
