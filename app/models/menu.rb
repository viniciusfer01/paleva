class Menu < ApplicationRecord
  has_many :stores
  has_many :stores, through: :store_menus 

  validates :name, presence: true
end
