require 'rails_helper'

describe 'a pre-registered employee creates an account' do 
  it 'succesfully' do 
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                        email: 'zezin@teclados.com', password: 'passwordpass')

    store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                  cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                  email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)
            
    employee = PreRegisteredEmployee.create!(email: 'tiringa@email.com', cpf: '24641470014', store: store)

    visit root_path
    expect(page).to have_content 'Login dos empregados'  
  end
end