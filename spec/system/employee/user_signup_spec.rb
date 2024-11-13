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
    click_on 'Login para funcionários'
    click_on 'Sign up'
    fill_in "E-mail",	with: "tiringa@email.com" 
    fill_in "CPF",	with: "24641470014" 
    fill_in "Senha",	with: "Passwordpasswordpassword" 
    fill_in "Confirme sua senha",	with: "Passwordpasswordpassword" 
    fill_in "Nome",	with: "Tiringa" 
    fill_in "Sobrenome",	with: "da Silva" 
    click_on 'Criar conta'

    expect(page).not_to have_content 'Por favor, registre sua loja.'
    expect(current_path).to eq root_path  
  end
end