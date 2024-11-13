require 'rails_helper'

describe "user pre-registers employee" do
  it "succesfully" do
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                        email: 'zezin@teclados.com', password: 'passwordpass')

    Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                  cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                  email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)
    
    login_as user
    visit root_path
    click_on 'Meus funcionários'
    click_on 'Pré cadastrar funcionário'
    fill_in "email",	with: "tiringa@email.com" 
    fill_in "CPF",	with: "24641470014" 
    click_on 'Gravar Funcionário'
      
    expect(page).to have_content 'Funcionário pré cadastrado com sucesso.'
    expect(page).to have_content 'CPF: 24641470014'
    expect(page).to have_content 'Email: tiringa@email.com'
    expect(page).to have_content 'Status: false'
    expect(current_path).to eq pre_registered_employees_path  
  end
end
