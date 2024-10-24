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

  private
  def dish_params
    params.require(:dish).permit(:name, :description, :calories)
  end
end