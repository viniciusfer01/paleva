class PreRegisteredEmployeesController < ApplicationController
  before_action :authenticate_user!

  def index
    @pre_registered_employees = current_user.store.pre_registered_employees
  end

  def new
    @pre_registered_employee = PreRegisteredEmployee.new 
  end

  def create
    @pre_registered_employee = PreRegisteredEmployee.new(pre_registered_employee_params)
    @pre_registered_employee.store = current_user.store

    if @pre_registered_employee.save
      redirect_to pre_registered_employees_path, notice: 'Funcionário pré cadastrado com sucesso.'
    else
      flash.now[:notice] = 'Não foi possível pré cadastrar o funcionário'
      render :new, status: :unprocessable_entity
    end
  end

  private
  def pre_registered_employee_params
    params.require(:pre_registered_employee).permit(:cpf, :email)
  end
end