require 'rails_helper'

describe 'User edits a dish' do
  it 'succesfully' do 
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                        email: 'zezin@teclados.com', password: 'passwordpass')

    store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                  cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                  email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

    dish = Dish.create!(name: 'Pizza', description: 'Prato Italiano, que serve 3 a 4 pessoas', calories: 1200, store: store)

    login_as user
    visit root_path
    click_on 'Meus pratos'
    click_on dish.name
    click_on 'Editar'
    fill_in "Nome",	with: "Lasanha" 
    click_on 'Enviar'
    
    expect(page).to have_content 'Edição do Prato Efetuada com sucesso.'
    expect(page).not_to have_content 'Pizza'
    expect(page).to have_content 'Lasanha'
    expect(page).to have_content 'Prato Italiano, que serve 3 a 4 pessoas'
    expect(page).to have_content '1200'
  end
end