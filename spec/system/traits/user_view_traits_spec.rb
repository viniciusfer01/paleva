require 'rails_helper'

describe "User sees dish traits" do
  it 'successfully' do 
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
      email: 'zezin@teclados.com', password: 'passwordpass')

    Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                  cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                  email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)
                  
    Trait.create!(name: 'Contém glúten')                        
    Trait.create!(name: 'Contém Lactose')                        
    Trait.create!(name: 'Prato Apimentado')  
    
    login_as user 
    visit root_path
    click_on 'Características'

    expect(current_path).to eq traits_path
    expect(page).to have_content 'Contém glúten' 
    expect(page).to have_content 'Contém Lactose' 
    expect(page).to have_content 'Prato Apimentado' 
  end  
end
