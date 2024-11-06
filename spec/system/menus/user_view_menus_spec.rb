require 'rails_helper'

describe "User sees menus" do
  it "succesfully" do
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                        email: 'zezin@teclados.com', password: 'passwordpass')

    Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                  cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                  email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

    Menu.create!(name: 'Café da Manhã')                  
    Menu.create!(name: 'Almoço')                  
    Menu.create!(name: 'Jantar')                  

    login_as user
    visit root_path
    click_on 'Meus Cardápios'
    
    expect(page).to have_content 'Cardápios do Estabelecimento'    
    expect(page).to have_content 'Café'    
    expect(page).to have_content 'Almoço'    
    expect(page).to have_content 'Jantar' 
  end

  it "but there isn't any menus" do
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
end
