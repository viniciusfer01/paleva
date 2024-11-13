class Store < ApplicationRecord
  belongs_to :user
  has_many :dishes
  has_many :beverages
  has_many :store_menus
  has_many :menus, through: :store_menus 
  has_many :orders
  has_many :pre_registered_employees
  
  validates :brand_name, :corporate_name, :cnpj, :address, :phone, :email, :schedule, :code, presence: true
  validates :brand_name, :corporate_name, :cnpj, :phone, :email, :code, uniqueness: true
  validates :phone, :numericality => true
  validates :phone, :length => {:minimum => 10, :maximum => 11}
  validates :email, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address" }
  before_validation :generate_unique_code
  validate :validate_cnpj

  protected
  def generate_unique_code
    self.code = SecureRandom.alphanumeric(6)
  end

  def validate_cnpj
    if !CNPJ.valid?(self.cnpj)
      self.errors.add(:cnpj, 'Inválido')
    end
  end
end
