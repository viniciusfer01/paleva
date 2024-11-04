require 'rails_helper'

describe "User registers a dish trait" do
  it 'successfully' do 
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
      email: 'zezin@teclados.com', password: 'passwordpass')

    Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                  cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                  email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)  
    
    login_as user 
    visit root_path
    click_on 'Características'
    click_on 'Nova Característica'
    fill_in "Nome",	with: "Contém Lactose" 
    click_on 'Salvar'

    expect(current_path).to eq traits_path
    expect(page).to have_content 'Característica salva com sucesso!'
    expect(page).to have_content 'Contém Lactose' 
  end  
end
