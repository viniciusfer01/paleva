class Beverage < ApplicationRecord
  belongs_to :store
  has_one_attached :photo
  enum :status, { active: 0, inactive: 1}

  validates :name, :description, presence: true
  validates :is_alcoholic, inclusion: { in: [true, false] }
end
