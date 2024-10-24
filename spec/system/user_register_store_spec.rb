require 'rails_helper'

describe "User registers their store" do
  it "succesfully" do
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
    email: 'zezin@teclados.com', password: 'passwordpass')

    login_as user
    visit root_path
    click_on 'Registrar Estabelecimento'
    fill_in "Razão Social",	with: "Zezin Alimentos LTDA" 
    fill_in "Nome Fantasia",	with: "Pastéis Zezin" 
    fill_in "CNPJ",	with: "7891237891" 
    fill_in "Endereço Completo",	with: "Rua das tulipas, 18" 
    fill_in "Telefone",	with: "99999999999" 
    fill_in "Email",	with: "pasteis@zezin.com" 
    fill_in "Horário de Funcionamento", with: "23456M123456"
    click_on 'Enviar'

    expect(page).to have_content 'Estabelecimento registrado com sucesso.'  
    expect(page).to have_content 'Estabelecimento:'  
    expect(page).to have_content 'Razão Social Zezin Alimentos LTDA'  
    expect(page).to have_content 'Nome Fantasia Pastéis Zezin'  
    expect(page).to have_content 'CNPJ 7891237891'  
    expect(page).to have_content 'Endereço Completo Rua das tulipas, 18'  
    expect(page).to have_content 'Horário de Funcionamento 23456M123456'  
    expect(page).to have_content 'Telefone 99999999999'  
    expect(page).to have_content 'Email pasteis@zezin.com'  
  end
end
