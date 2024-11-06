class MenusController < ApplicationController
  before_action :authenticate_user!
  def new
    @menu = Menu.new
  end

  def create 
    @menu = Menu.new(menu_params)

    if current_user.store.menus.find_by(name: @menu.name)
      return redirect_to root_path, notice: "Esse nome de cardápio já está em uso"
    end

    if @menu.save
      redirect_to @menu, notice: 'Cardápio cadastrado com sucesso.' 
    else 
      flash.now[:notice] = 'Não foi possível salvar o cardápio.'
      render :new, status: :unprocessable_entity
    end
  end

  def show 
    @menu = current_user.store.menus.find(params[:id])
    @dishes = @menu.dishes.active
    @beverages = @menu.beverages.active
  end

  def index 
    @menus = current_user.store.menus
  end

  private 
  def menu_params
    params.require(:menu).permit(:name)
  end
end