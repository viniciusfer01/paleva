require 'rails_helper'

describe "User creates an account" do
  it "succesfully" do
    visit root_path
    click_on 'Sign up'
    fill_in "E-mail",	with: "zezin@teclados.com"                         
    fill_in "Senha",	with: "passwordpass"
    fill_in "Confirme sua senha",	with: "passwordpass"
    fill_in "CPF",	with: "66101052001"
    fill_in "Nome",	with: "Zezin"
    fill_in "Sobrenome", with: "dos teclados"
    click_on 'Criar Conta'
    
    expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'Registrar Estabelecimento'
    expect(page).not_to have_content 'Log in'
  end

  it "and misses fields" do
    visit root_path
    click_on 'Sign up'
    fill_in "E-mail",	with: ""                         
    fill_in "Senha",	with: "passwordpass"
    fill_in "Confirme sua senha",	with: "passwordpass"
    fill_in "CPF",	with: "66101052001"
    fill_in "Nome",	with: "Zezin"
    fill_in "Sobrenome", with: "dos teclados"
    click_on 'Criar Conta'
    
    expect(page).to have_content 'Log in'
    expect(page).to have_content 'Não foi possível salvar usuário' 
  end 
end
