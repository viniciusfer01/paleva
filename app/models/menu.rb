class Menu < ApplicationRecord
  belongs_to :store
  has_many :menu_items
  has_many :dishes, through: :menu_items
  has_many :beverages, through: :menu_items

  validates :name, presence: true
end
