class Beverage < ApplicationRecord
  belongs_to :store
  has_one_attached :photo
  has_many :portions, dependent: :destroy
  has_many :menu_items
  has_many :menus, through: :menu_items
  enum :status, { active: 0, inactive: 1}

  validates :name, :description, presence: true
  validates :is_alcoholic, inclusion: { in: [true, false] }
end
