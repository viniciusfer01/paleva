class Portion < ApplicationRecord
  belongs_to :beverage, optional: true
  belongs_to :dish, optional: true
end
