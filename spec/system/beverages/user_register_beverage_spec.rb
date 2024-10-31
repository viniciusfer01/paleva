require 'rails_helper'

describe "User registers beverages" do
    it "unsuccessful if not authenticated" do
      visit root_path

      expect(page).not_to have_content 'Registrar Bebidas'
    end

    it "succesfully" do
      user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
      email: 'zezin@teclados.com', password: 'passwordpass')

      Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                        cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                        email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

      login_as user
      visit root_path
      click_on 'Registrar Bebidas'
      fill_in "Nome",	with: "Suco de maracujá"
      fill_in "Descrição",	with: "Suco de frutas natural."
      fill_in "Calorias",	with: "120"
      click_on 'Enviar'

      expect(page).to have_content 'Registro da bebida Efetuado com sucesso.'  
      expect(page).to have_content 'Bebida: Suco de maracujá'  
      expect(page).to have_content 'Descrição: Suco de frutas natural.'  
      expect(page).to have_content '120 kcal'  
    end

    it "and misses a field" do
      user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
      email: 'zezin@teclados.com', password: 'passwordpass')

      Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                        cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                        email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

      login_as user
      visit root_path
      click_on 'Registrar Bebidas'
      fill_in "Nome",	with: ""
      fill_in "Descrição",	with: "Suco de frutas natural."
      fill_in "Calorias",	with: "120"
      click_on 'Enviar'

      expect(page).not_to have_content 'Registro da bebida Efetuado com sucesso.'  
      expect(page).to have_content 'Não foi possível registrar a bebida.'         
      expect(page).to have_content 'Nome não pode ficar em branco'         
    end
end