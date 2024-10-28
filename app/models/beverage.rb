class Beverage < ApplicationRecord
  belongs_to :store
  has_one_attached :photo

  validates :name, :description, presence: true
  validates :is_alcoholic, inclusion: { in: [true, false] }
end
