require 'rails_helper'

describe "User logs in" do
  it "succesfully" do
    User.create!(cpf: '78945612', name: 'Zezin', last_name: 'do Teclados', 
                        email: 'zezin@teclados.com', password: 'passwordpass')

    visit new_user_session_path
    fill_in "Email",	with: "zezin@teclados.com"                         
    fill_in "Senha",	with: "passwordpass"
    
    expect(page).to have_content 'Login realizado com sucesso' 
  end
end
