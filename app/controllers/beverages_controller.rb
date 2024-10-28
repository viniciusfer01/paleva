class BeveragesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_owner, only: [:show, :edit, :update, :destroy]

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
    @beverage = Beverage.find params[:id]
  end

  def edit 
    @beverage = Beverage.find params[:id]
  end

  def update
    @beverage = Beverage.find params[:id]
    
    if @beverage.update dish_params
      redirect_to @beverage, notice: "Edição da bebida efetuada com sucesso."  
    else
      flash.now[:notice] = 'Não foi possível editar a bebida.'
      render :edit, status: :unprocessable_entity
    end
  end

  def index
    @beverages = Beverage.where(store: current_user.store) 
  end

  def destroy
    @beverage = Beverage.find params[:id]

    if @beverage.destroy!
      redirect_to beverages_path, notice: 'Bebida deletada com sucesso'
    end
  end

  private
  def dish_params
    params.require(:beverage).permit(:name, :description, :calories, :is_alcoholic)
  end

  def check_owner
    beverage = Beverage.find params[:id]
    if current_user.store != beverage.store
      redirect_to root_path 
    end
  end
end