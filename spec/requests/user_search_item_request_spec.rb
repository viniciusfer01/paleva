require 'rails_helper'

describe "User searches for an item" do
    it "succesfully" do
      user = User.create!(cpf: '96287760028', name: 'Geraldo', last_name: 'Antunes', 
      email: 'geraldo@refrigeracao.com', password: 'passwordpass')

      second_user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                                 email: 'zezin@teclados.com', password: 'passwordpass')
      
      store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
      cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
      email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

      second_store = Store.create!(corporate_name: 'Zezin Alimentos2 LTDA', brand_name: 'Pastéis Zezin2', 
                    cnpj: '66345931000130', address: 'Rua das tulipas, 180', phone: '2345123426', 
                    email: 'pasteis2@zezin.com', schedule: '23456M12346', user: second_user)
      
      Dish.create!(name: 'Pizza', description: 'Prato Italiano, que serve 3 a 4 pessoas', calories: 1200, store: store)
      Dish.create!(name: 'Lasanha', description: 'Prato Italiano, que serve 3 a 4 pessoas', calories: 1200, store: store)
      Dish.create!(name: 'Pizza marguerita', description: 'Prato Italiano, que serve 3 a 4 pessoas', calories: 1200, store: second_store)
      
      login_as user
      get(search_path, params: { query: 'Pizza'})
      
      expect(response.body).to include('Não houveram bebidas encontradas.')  
      expect(response.body).to include('Pizza')  
      expect(response.body).not_to include('Lasanha')  
      expect(response.body).not_to include('Pizza marguerita')  
    end
end