class MenuItem < ApplicationRecord
  belongs_to :menu
  belongs_to :dish, optional: true
  belongs_to :beverage, optional: true

  before_save :must_have_dishes_or_beverages

  private
  def must_have_dishes_or_beverages
    if self.dish.nil? && self.beverage.nil?
      errors.add(:base, 'Menu item must have at least one dish or beverage')
    end
  end
end
