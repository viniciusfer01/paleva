class MenusController < ApplicationController
  def new
    @menu = Menu.new
  end

  def create 
    @menu = Menu.new(menu_params)

    if @menu.save
      redirect_to @menu, notice: 'Cardápio cadastrado com sucesso.' 
    else 
    end
  end

  def show 
    @menu = Menu.find(params[:id])
  end

  private 
  def menu_params
    params.require(:menu).permit(:name)
  end
end