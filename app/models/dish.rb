class Dish < ApplicationRecord
  belongs_to :store
  has_one_attached :photo
  has_many :portions, dependent: :destroy
  has_many :dish_traits
  has_many :traits, through: :dish_traits
  enum :status, { active: 0, inactive: 1 }
  has_many :menu_items
  has_many :menus, through: :menu_items

  validates :name, :description, presence: true
end
