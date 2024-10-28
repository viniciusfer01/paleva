require 'rails_helper'

describe 'User edits a beverage' do
  it 'succesfully' do 
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                        email: 'zezin@teclados.com', password: 'passwordpass')

    store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                  cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                  email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

    beverage = Beverage.create!(name: 'Suco de limão', description: 'Suco de fruta natural', is_alcoholic: false, calories: 100, store: store)

    login_as user
    visit edit_beverage_path(beverage)
    fill_in "Nome",	with: "Suco de acerola" 
    click_on 'Enviar'

    expect(page).to have_content 'Edição da bebida efetuada com sucesso.'
    expect(page).not_to have_content 'Suco de limão'
    expect(page).to have_content 'Suco de acerola'
    expect(page).to have_content 'É alcoólica?' 
    expect(page).to have_content 'Suco de fruta natural'
    expect(page).to have_content '100'
  end
end