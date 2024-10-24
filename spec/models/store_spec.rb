require 'rails_helper'

RSpec.describe Store, type: :model do
  describe "#valid?" do
    context "if a field is blank" do
      it "false if corporate_name" do
        user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                            email: 'zezin@teclados.com', password: 'passwordpass')
        store = Store.new(corporate_name: '', brand_name: 'Pastéis Zezin', 
                          cnpj: '97654324', address: 'Rua das tulipas, 18', phone: '2345123456', 
                          email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)
        
        result = store.valid?
        
        expect(result).to eq false  
      end

      it "false if brand_name" do
        user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                            email: 'zezin@teclados.com', password: 'passwordpass')
        store = Store.new(corporate_name: 'Zezin Alimentos LTDA', brand_name: '', 
                          cnpj: '97654324', address: 'Rua das tulipas, 18', phone: '2345123456', 
                          email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)
        
        result = store.valid?
        
        expect(result).to eq false  
      end

      it "false if CNPJ is empty" do
        user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                            email: 'zezin@teclados.com', password: 'passwordpass')
        store = Store.new(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                          cnpj: '', address: 'Rua das tulipas, 18', phone: '2345123456', 
                          email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)
        
        result = store.valid?
        
        expect(result).to eq false  
      end

      it "false if address" do
        user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                            email: 'zezin@teclados.com', password: 'passwordpass')
        store = Store.new(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                          cnpj: '97654324', address: '', phone: '2345123456', 
                          email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)
        
        result = store.valid?
        
        expect(result).to eq false  
      end

      it "false if phone" do
        user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                            email: 'zezin@teclados.com', password: 'passwordpass')
        store = Store.new(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                          cnpj: '97654324', address: 'Rua das tulipas, 18', phone: '', 
                          email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)
        
        result = store.valid?
        
        expect(result).to eq false  
      end

      it "false if email" do
        user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                            email: 'zezin@teclados.com', password: 'passwordpass')
        store = Store.new(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                          cnpj: '97654324', address: 'Rua das tulipas, 18', phone: '2345123456', 
                          email: '', schedule: '23456M123456', user: user)
        
        result = store.valid?
        
        expect(result).to eq false  
      end

      it "false if schedule" do
        user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                            email: 'zezin@teclados.com', password: 'passwordpass')
        store = Store.new(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                          cnpj: '97654324', address: 'Rua das tulipas, 18', phone: '2345123456', 
                          email: 'pasteis@zezin.com', schedule: '', user: user)
        
        result = store.valid?
        
        expect(result).to eq false  
      end
    end
  end

  context "if fields are invalid," do
    it "false if cnpj is invalid" do
      user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                          email: 'zezin@teclados.com', password: 'passwordpass')
      store = Store.new(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                        cnpj: '97654324', address: 'Rua das tulipas, 18', phone: '2345123456', 
                        email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)
      
      result = store.valid?
      
      expect(result).to eq false  
    end

    it "false if phone is invalid" do
      user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                          email: 'zezin@teclados.com', password: 'passwordpass')
      store = Store.new(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                        cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '23423456', 
                        email: 'pasteis@zezin.com', schedule: '23456M123456', user: user)
      
      result = store.valid?
      
      expect(result).to eq false  
    end

    it "false if email is invalid" do
      user = User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
                          email: 'zezin@teclados.com', password: 'passwordpass')
      store = Store.new(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                        cnpj: '40599424000139', address: 'Rua das tulipas, 18', phone: '2345123456', 
                        email: 'pasteis_zezin', schedule: '23456M123456', user: user)
      
      result = store.valid?
      
      expect(result).to eq false  
    end
  end
end
