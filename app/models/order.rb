class Order < ApplicationRecord
  belongs_to :user
  belongs_to :store
  has_many :order_items, dependent: :destroy 
  has_many :portions, through: :order_items

  validates :name, :price, presence: true
  validates :code, uniqueness: true
  validates :email, presence: true, unless: -> { phone.present? }
  validates :phone, presence: true, unless: -> { email.present? }
  
  enum :status, { pending: 0, prepping: 1, canceled: 2, ready: 3, delivered: 4 }

  before_create :generate_code

  accepts_nested_attributes_for :order_items, allow_destroy: true

  private
  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end
end
