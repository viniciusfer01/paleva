class DishesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_owner, only: [:show, :edit, :update, :destroy]

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

  def index
    @dishes = Dish.where(store: current_user.store) 
  end

  def destroy
    @dish = Dish.find params[:id]

    if @dish.destroy!
      redirect_to dishes_path, notice: 'Prato deletado com sucesso'
    end
  end

  private
  def dish_params
    params.require(:dish).permit(:name, :description, :calories)
  end

  def check_owner
    dish = Dish.find params[:id]
    if current_user.store != dish.store
      redirect_to root_path 
    end
  end
end