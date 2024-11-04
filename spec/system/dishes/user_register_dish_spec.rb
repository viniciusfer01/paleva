require 'rails_helper'

describe "User registers dishes" do
    it "unsuccessful if not authenticated" do
      visit root_path

      expect(page).not_to have_content 'Registrar Pratos'
    end

    it "succesfully" do
      user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
      email: 'zezin@teclados.com', password: 'passwordpass')

      Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                    cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                    email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)      
                    
      Trait.create!(name: 'Contém glúten')                        
      Trait.create!(name: 'Contém Lactose')                        
      Trait.create!(name: 'Prato Apimentado')  

      login_as user
      visit root_path
      click_on 'Registrar Pratos'
      fill_in "Nome",	with: "Pizza"
      fill_in "Descrição",	with: "Prato típico da cozinha Italiana, serve 3 a 4 pessoas."
      fill_in "Calorias",	with: "1200"
      select 'Contém Lactose', from: 'Tipos'
      select 'Contém glúten', from: 'Tipos'
      click_on 'Enviar'
      
      
      expect(page).to have_content 'Registro do Prato Efetuado com sucesso.'  
      expect(page).to have_content 'Prato: Pizza'  
      expect(page).to have_content 'Descrição: Prato típico da cozinha Italiana, serve 3 a 4 pessoas.'  
      expect(page).to have_content '1200 kcal'  
      expect(page).to have_content 'Contém glúten'  
      expect(page).to have_content 'Contém Lactose'  
    end

    it "and misses a field" do
      user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
      email: 'zezin@teclados.com', password: 'passwordpass')

      Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                        cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                        email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

      login_as user
      visit root_path
      click_on 'Registrar Pratos'
      fill_in "Nome",	with: ""
      fill_in "Descrição",	with: "Prato típico da cozinha Italiana, serve 3 a 4 pessoas."
      fill_in "Calorias",	with: "1200"
      click_on 'Enviar'

      expect(page).not_to have_content 'Registro do Prato Efetuado com sucesso.'  
      expect(page).to have_content 'Não foi possível registrar o prato.'         
      expect(page).to have_content 'Nome não pode ficar em branco'         
    end
end