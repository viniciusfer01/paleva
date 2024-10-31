class BeveragesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_beverage_and_check_owner, only: [:show, :edit, :update, :destroy, :inactive, :active]

  def new
    @beverage = Beverage.new
  end

  def create
    @beverage = Beverage.new(dish_params)
    @beverage.store = current_user.store

    if @beverage.save
      redirect_to @beverage, notice: "Registro da bebida Efetuado com sucesso." 
    else
      flash.now[:notice] = 'Não foi possível registrar a bebida.'
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit 
  end

  def update    
    if @beverage.update dish_params
      redirect_to @beverage, notice: "Edição da bebida efetuada com sucesso."  
    else
      flash.now[:notice] = 'Não foi possível editar a bebida.'
      render :edit, status: :unprocessable_entity
    end
  end

  def index
    @beverages = current_user.store.beverages
  end

  def destroy
    if @beverage.destroy!
      redirect_to beverages_path, notice: 'Bebida deletada com sucesso'
    end
  end

  def inactive
    @beverage.inactive!

    redirect_to @beverage, notice: 'Status da Bebida atualizado com sucesso.'
  end

  def active
    @beverage.active!

    redirect_to @beverage, notice: 'Status da Bebida atualizado com sucesso.'
  end

  private
  def dish_params
    params.require(:beverage).permit(:name, :description, :calories, :is_alcoholic)
  end

  def set_beverage_and_check_owner
    @beverage = Beverage.find params[:id]
    if @beverage.store != current_user.store 
      redirect_to root_path 
    end
  end
end