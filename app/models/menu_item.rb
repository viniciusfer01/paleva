class MenuItem < ApplicationRecord
  belongs_to :menu
  belongs_to :dish, optional: true
  belongs_to :beverage, optional: true
end
