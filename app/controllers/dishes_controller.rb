class DishesController < ApplicationController
  before_action :authenticate_user!

  def new
    @dish = Dish.new
  end

  def create
    @dish = Dish.new(dish_params)
    @dish.store = current_user.store

    if @dish.save
      redirect_to @dish, notice: "Registro do Prato Efetuado com sucesso." 
    else
      flash.now[:notice] = 'Não foi possível registrar o prato.'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @dish = Dish.find params[:id]
  end

  def edit 
    @dish = Dish.find params[:id]
  end

  def update
    @dish = Dish.find params[:id]
    
    if @dish.update dish_params
      redirect_to @dish, notice: "Edição do Prato Efetuada com sucesso."  
    else
      flash.now[:notice] = 'Não foi possível editar o prato.'
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def dish_params
    params.require(:dish).permit(:name, :description, :calories)
  end
end