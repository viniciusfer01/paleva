class PortionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_model
  def new 
    @portion = @portionable.portions.new
  end

  def create
    @portion = @portionable.portions.new(portion_params)

    if @portionable.portions.create(portion_params)
      redirect_to @portionable, notice: 'Porção cadastrada com sucesso'
    else
      flash.now[:notice] = 'Não foi possível cadastrar a porção'
      render :new, status: :unprocessable_entity
    end
  end

  private
  def portion_params
    params.require(:portion).permit(:description, :price)
  end

  def set_model 
    @portionable = Dish.find(params[:dish_id]) if params[:dish_id]
    @portionable = Beverage.find(params[:beverage_id]) if params[:beverage_id]
  end
end