class Employee < ApplicationRecord
  belongs_to :store
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :cpf, uniqueness: true
  validates :email, :password, :cpf, :name, :last_name, presence: true

  validate :validate_cpf
  before_validation :associate_store, on: :create
       
  private

  def validate_cpf
    if !CPF.valid?(self.cpf)
      self.errors.add(:cpf, 'Inválido')
    end
  end

  def associate_store
    pre_register = PreRegisteredEmployee.find_by(cpf: self.cpf)
    self.store = pre_register.store
    pre_register.used = true
  end
end
