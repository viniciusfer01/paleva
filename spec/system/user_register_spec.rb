describe "User logs in" do
  it "succesfully" do
    User.create!(cpf: '78945612', name: 'Zezin', surname: 'do Teclados', 
                        email: 'zezin@teclados.com', password: 'passwordpass')

    fill_in "CPF",	with: "78945612"                         
    fill_in "Senha",	with: "passwordpass"
    
    expect(page).to have_content 'Login realizado com sucesso' 
  end
end
