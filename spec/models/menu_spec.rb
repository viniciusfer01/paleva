require 'rails_helper'

RSpec.describe Menu, type: :model do
  describe "#valid?" do
    it "isn't valid if name is blank" do
      menu = Menu.new(name: '')
      result = menu.valid?

      expect(result).to eq false  
    end
  end
end
