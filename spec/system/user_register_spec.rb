describe "User logs in" do
  it "succesfully" do
    User.create!(cpf: '78945612', name: 'Zezin', last_name: 'do Teclados', 
                        email: 'zezin@teclados.com', password: 'passwordpass')

    visit root_path
    fill_in "CPF",	with: "78945612"                         
    fill_in "Senha",	with: "passwordpass"
    
    expect(page).to have_content 'Login realizado com sucesso' 
  end
end
