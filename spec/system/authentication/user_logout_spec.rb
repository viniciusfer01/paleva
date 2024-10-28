require 'rails_helper'

describe "User logs out" do
  it "succesfully" do
    user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                        email: 'zezin@teclados.com', password: 'passwordpass')

    login_as user
    visit root_path 
    
    within('nav') do 
      click_on 'Sair'  
    end

    within('nav') do 
      expect(page).to have_content 'Entrar'  
      expect(page).not_to have_content 'Sair'  
    end
  end
end
