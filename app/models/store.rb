class Store < ApplicationRecord
  belongs_to :user
  validates :brand_name, :corporate_name, :cnpj, :address, :phone, :email, :schedule, :code, presence: true
  validates :brand_name, :corporate_name, :cnpj, :phone, :email, :code, uniqueness: true
  validates :phone, :numericality => true
  validates :phone, :length => {:minimum => 10, :maximum => 11}
  validates :email, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address" }
  before_validation :generate_unique_code
  validate :validate_cnpj

  protected
  def generate_unique_code
    self.code = SecureRandom.hex(6)
  end

  def validate_cnpj
    if !CNPJ.valid?(self.cnpj)
      self.errors.add(:cnpj, 'Inválido')
    end
  end
end
