require 'rails_helper'

describe "User logs in" do
  it "succesfully" do
    User.create!(cpf: '78945612', name: 'Zezin', last_name: 'do Teclados', 
                        email: 'zezin@teclados.com', password: 'passwordpass')

    visit new_user_session_path
    fill_in "E-mail",	with: "zezin@teclados.com"                         
    fill_in "Senha",	with: "passwordpass"
    click_on "Log in"
    
    expect(page).to have_content 'Login efetuado com sucesso.' 
  end
end
