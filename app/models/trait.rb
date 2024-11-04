class Trait < ApplicationRecord
  has_many :dish_traits
  has_many :dishes, through: :dish_traits
  has_many :stores_traits
  has_many :stores, through: :store_traits

  validates :name, presence: true, uniqueness: true
end
