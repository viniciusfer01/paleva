class Dish < ApplicationRecord
  belongs_to :store
  has_one_attached :photo
  has_many :portions
  enum :status, { active: 0, inactive: 1 }

  validates :name, :description, presence: true
end
