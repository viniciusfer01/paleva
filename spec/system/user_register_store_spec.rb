require 'rails_helper'

describe "User registers their store" do
  it "succesfully" do
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
    email: 'zezin@teclados.com', password: 'passwordpass')

    login_as user
    visit root_path
    click_on 'Cadastrar Estabelecimento'
    fill_in "Nome Fantasia",	with: "Pastéis Zezin" 
    fill_in "Razão Social",	with: "Zezin Alimentos LTDA" 
    fill_in "CNPJ",	with: "789123" 
    fill_in "Endereço Completo",	with: "rua das tulipas, 18" 
    fill_in "Telefone",	with: "99999999999" 
    fill_in "Email",	with: "pasteis@zezin.com" 
    click_on 'Enviar'

    expect(page).to have_content 'Estabelecimento cadastrado com sucesso'  
    expect(page).to have_content '7891237891'  
    expect(page).to have_content 'pasteis@zezin.com'  
    expect(page).to have_content 'Pastéis Zezin'  

  end
end
