require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do   
    context "if a field is incomplete" do
      it "false if cpf is empty" do
        user = User.new(cpf: '', name: 'Zezin', last_name: 'do Teclados', 
        email: 'zezin@teclados.com', password: 'passwordpass')
        
        result = user.valid?
        
        expect(result).to eq false 
      end

      it "false if name is empty" do
        user = User.new(cpf: '78945612', name: '', last_name: 'do Teclados', 
        email: 'zezin@teclados.com', password: 'passwordpass')
        
        result = user.valid?
        
        expect(result).to eq false 
      end

      it "false if last name is empty" do
        user = User.new(cpf: '78945612', name: 'Zezin', last_name: '', 
        email: 'zezin@teclados.com', password: 'passwordpass')
        
        result = user.valid?
        
        expect(result).to eq false 
      end

      it "false if email is empty" do
        user = User.new(cpf: '78945612', name: 'Zezin', last_name: 'do Teclados', 
        email: '', password: 'passwordpass')
        
        result = user.valid?
        
        expect(result).to eq false 
      end

      it "false if password is empty" do
        user = User.new(cpf: '78945612', name: 'Zezin', last_name: 'do Teclados', 
        email: 'zezin@teclados.com', password: '')
        
        result = user.valid?
        
        expect(result).to eq false 
      end
    end
    context "if fields are invalid," do
      it "false if password is short" do
        user = User.new(cpf: '78945612', name: 'Zezin', last_name: 'do Teclados', 
        email: 'zezin@teclados.com', password: '12345')
        
        result = user.valid?
        
        expect(result).to eq false 
      end
      
      it "false if cpf isn't unique" do
        User.create!(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
        email: 'zezin@teclados.com', password: '12345678910111213')
        user = User.new(cpf: '66101052001', name: 'Zezin', last_name: 'do Teclados', 
        email: 'zezin@teclados.com', password: '12345678910111213')
        
        result = user.valid?
        
        expect(result).to eq false 
      end

      it "false if cpf isn't valid" do
        user = User.new(cpf: '78945612345', name: 'Zezin', last_name: 'do Teclados', 
        email: 'zezin@teclados.com', password: '12345678910111213')
        
        result = user.valid?
        
        expect(result).to eq false 
      end
    end
  end
end
