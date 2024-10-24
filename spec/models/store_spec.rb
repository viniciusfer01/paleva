require 'rails_helper'

RSpec.describe Store, type: :model do
  describe "#valid?" do
    context "if a field is blank" do
      it "false if corporate_name" do
        store = Store.new(corporate_name: '', brand_name: 'Pastéis Zezin', 
                          cnpj: '97654324', address: 'Rua das tulipas, 18', phone: '2345123456', 
                          email: 'pasteis@zezin.com', schedule: '23456M123456')
        
        result = store.valid?
        
        expect(result).to eq false  
      end

      it "false if brand_name" do
        store = Store.new(corporate_name: 'Zezin Alimentos LTDA', brand_name: '', 
                          cnpj: '97654324', address: 'Rua das tulipas, 18', phone: '2345123456', 
                          email: 'pasteis@zezin.com', schedule: '23456M123456')
        
        result = store.valid?
        
        expect(result).to eq false  
      end

      it "false if CNPJ is empty" do
        store = Store.new(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
        cnpj: '', address: 'Rua das tulipas, 18', phone: '2345123456', 
        email: 'pasteis@zezin.com', schedule: '23456M123456')
        
        result = store.valid?
        
        expect(result).to eq false  
      end

      it "false if address" do
        store = Store.new(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                          cnpj: '97654324', address: '', phone: '2345123456', 
                          email: 'pasteis@zezin.com', schedule: '23456M123456')
        
        result = store.valid?
        
        expect(result).to eq false  
      end

      it "false if phone" do
        store = Store.new(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                          cnpj: '97654324', address: 'Rua das tulipas, 18', phone: '', 
                          email: 'pasteis@zezin.com', schedule: '23456M123456')
        
        result = store.valid?
        
        expect(result).to eq false  
      end

      it "false if email" do
        store = Store.new(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                          cnpj: '97654324', address: 'Rua das tulipas, 18', phone: '2345123456', 
                          email: '', schedule: '23456M123456')
        
        result = store.valid?
        
        expect(result).to eq false  
      end

      it "false if schedule" do
        store = Store.new(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                          cnpj: '97654324', address: 'Rua das tulipas, 18', phone: '2345123456', 
                          email: 'pasteis@zezin.com', schedule: '')
        
        result = store.valid?
        
        expect(result).to eq false  
      end
    end
  end

  context "if fields are invalid," do
    it "false if cnpj is invalid" do
      store = Store.new(corporate_name: 'Zezin Alimentos LTDA', brand_name: 'Pastéis Zezin', 
                        cnpj: '97654324', address: 'Rua das tulipas, 18', phone: '2345123456', 
                        email: 'pasteis@zezin.com', schedule: '23456M123456')
      
      result = store.valid?
      
      expect(result).to eq false  
    end
  end
end
