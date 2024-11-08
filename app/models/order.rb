class Order < ApplicationRecord
  belongs_to :user
  belongs_to :store

  validates :name, :price, presence: true
  validates :code, uniqueness: true
  
  enum :status, { pending: 0, prepping: 1, canceled: 2, ready: 3, delivered: 4 }

  before_create :generate_code

  private
  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end
end
