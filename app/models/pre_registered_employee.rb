class PreRegisteredEmployee < ApplicationRecord
  belongs_to :store

  validates :email, :cpf, presence: true 
  validates :email, :cpf, uniqueness: true 

  validate :validate_cpf

  private
  def validate_cpf
    if !CPF.valid?(self.cpf)
      self.errors.add(:cpf, 'Inválido')
    end
  end
end
