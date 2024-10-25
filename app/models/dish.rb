class Dish < ApplicationRecord
  belongs_to :store
  has_one_attached :photo

  validates :name, :description, presence: true
end