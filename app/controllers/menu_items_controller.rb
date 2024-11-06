class MenuItemsController < ApplicationController 
  def new
    @menu = current_user.store.menus.find(params[:menu_id])
    @menu_item = MenuItem.new
    @dishes = current_user.store.dishes
    @beverages = current_user.store.beverages
  end

  def create
    @menu = current_user.store.menus.find(params[:menu_id])
    dish_ids = menu_item_params[:dish_ids].reject(&:blank?)
    beverage_ids = menu_item_params[:beverage_ids].reject(&:blank?)

    @menu.dishes << Dish.find(dish_ids) unless dish_ids.empty?
    @menu.beverages << Beverage.find(beverage_ids) unless beverage_ids.empty?

    if @menu.save
      redirect_to @menu, notice: 'Itens cadastrados com sucesso.'
    else 
      @dishes = current_user.store.dishes
      @beverages = current_user.store.beverages
      flash.now[:notice] = 'Não foi possível cadastrar os itens'
      render :new, status: :unprocessable_entity
    end
  end

  private
  def menu_item_params
    params.require(:menu_item).permit(dish_ids: [], beverage_ids: [])
  end
end