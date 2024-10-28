require 'rails_helper'

describe "User views their beverage" do  
  it "succesfully" do
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
    email: 'zezin@teclados.com', password: 'passwordpass')
    
    store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
    cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
    email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)
    
    Beverage.create!(name: 'Refrigerante Guaraná', description: 'Refrigerante feito com uma fruta típica brasileira', is_alcoholic: false, calories: 1200, store: store)
    
    login_as user
    visit root_path
    click_on 'Minhas Bebidas'
    click_on 'Refrigerante Guaraná'    
    
    expect(page).to have_content 'Bebida: Refrigerante Guaraná'  
    expect(page).to have_content 'Descrição: Refrigerante feito com uma fruta típica brasileira'  
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
    
    beverage = Beverage.create!(name: 'Refrigerante Guaraná', description: 'Refrigerante feito com uma fruta típica brasileira', calories: 1200, is_alcoholic: false, store: store)
    
    login_as first_user
    visit beverage_path beverage
    
    expect(page).not_to have_content 'Bebida: Refrigerante Guaraná'  
    expect(page).not_to have_content 'Descrição: Refrigerante feito com uma fruta típica brasileira'  
    expect(page).not_to have_content '1200 kcal'
    expect(page).to have_content 'Por favor, registre sua loja.'
  end
end