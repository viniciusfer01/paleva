class PortionsController < ApplicationController
  def new 
    @beverage = Beverage.find(params[:beverage_id])
    @portion = Portion.new
  end

  def create
    @beverage = Beverage.find(params[:beverage_id])

    if @beverage.portions.create(portion_params)
      redirect_to @beverage, notice: 'Porção cadastrada com sucesso'
    else
    end
  end

  private
  def portion_params
    params.require(:portion).permit(:description, :price)
  end
end