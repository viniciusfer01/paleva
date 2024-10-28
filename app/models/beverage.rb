class Beverage < ApplicationRecord
  belongs_to :store
  has_one_attached :photo

  validates :name, :description, :is_alcoholic, presence: true
end
