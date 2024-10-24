class Store < ApplicationRecord
  belongs_to :user
  validates :brand_name, :corporate_name, :cnpj, :address, :phone, :email, :schedule, :code, presence: true
  validates :brand_name, :corporate_name, :cnpj, :phone, :email, :code, uniqueness: true
  before_validation :generate_unique_code

  protected
  def generate_unique_code
    self.code = SecureRandom.hex(6)
  end

end
