require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "#valid?" do
    context "when there's an empty field," do
      it "fails because name cant't be empty" do
        user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                            email: 'zezin@teclados.com', password: 'passwordpass')
        store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                              cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                              email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

        dish = Dish.new(name: '', description: 'Prato Italiano, que serve 3 a 4 pessoas', calories: 1200, store: store)

        result = dish.valid?
        
        expect(result).to eq false  
      end

      it "fails because description cant't be empty" do
        user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                            email: 'zezin@teclados.com', password: 'passwordpass')
        store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                              cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                              email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

        dish = Dish.new(name: 'Pizza', description: '', calories: 1200, store: store)

        result = dish.valid?
        
        expect(result).to eq false  
      end

      it "fails because store cant't be empty" do
        dish = Dish.new(name: 'Pizza', description: '', calories: 1200)

        result = dish.valid?
        
        expect(result).to eq false  
      end

      it "succeeds when calories are empty" do
        user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                            email: 'zezin@teclados.com', password: 'passwordpass')
        store = Store.create!(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                              cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                              email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)

        dish = Dish.new(name: 'Pizza', description: 'Prato Italiano, que serve 3 a 4 pessoas', store: store)

        result = dish.valid?
        
        expect(result).to eq true  
      end
    end
  end
  
end
