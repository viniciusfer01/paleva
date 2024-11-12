class Portion < ApplicationRecord
  belongs_to :beverage, optional: true
  belongs_to :dish, optional: true
  has_many :order_items, dependent: :destroy

  validates :price, presence: true
end
