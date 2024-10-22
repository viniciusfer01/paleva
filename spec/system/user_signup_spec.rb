require 'rails_helper'

describe "User creates an account" do
  it "Succesfully" do
    visit root_path
    click_on 'Criar Conta'
    fill_in "E-mail",	with: "zezin@teclados.com"                         
    fill_in "Senha",	with: "passwordpass"
    fill_in "Confirme sua senha",	with: "passwordpass"
    fill_in "CPF",	with: "2313213213"
    fill_in "Nome",	with: "Zezin"
    fill_in "Sobrenome", with: "dos teclados"
    click_on 'Criar Usuário'
    
    expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'Registrar Estabelecimento'
    expect(page).not_to have_content 'Log in'
  end
end
