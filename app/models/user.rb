require "cpf_cnpj"

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :cpf, uniqueness: true
  validates :email, :password, :cpf, :name, :last_name, presence: true

  validate :validate_cpf

  private
  def validate_cpf
    if !CPF.valid?(self.cpf)
      self.errors.add(:cpf, 'Inválido')
    end
  end
end
