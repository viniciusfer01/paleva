class Menu < ApplicationRecord
  has_many :stores
  has_many :stores, through: :store_menus 
  has_many :menu_items
  has_many :dishes, through: :menu_items
  has_many :beverages, through: :menu_items

  validates :name, presence: true
end
