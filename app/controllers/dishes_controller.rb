class DishesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dish_and_check_owner, only: [:show, :edit, :update, :destroy, :inactive, :active]

  def new
    @dish = Dish.new
    @traits = Trait.all
  end

  def create
    @dish = Dish.new(dish_params)
    @dish.store = current_user.store

    if @dish.save
      trait_ids = params[:dish][:trait_ids].reject(&:blank?)
      @dish.traits << Trait.find(trait_ids) if trait_ids.any?
      redirect_to @dish, notice: "Registro do Prato Efetuado com sucesso." 
    else
      @traits = Trait.all
      flash.now[:notice] = 'Não foi possível registrar o prato.'
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit 
    @traits = Trait.all
  end

  def update
    @traits = Trait.all
    trait_ids = params[:dish][:trait_ids].reject(&:blank?)
    @dish.traits << Trait.find(trait_ids) if trait_ids.any?

    if @dish.update dish_params
      redirect_to @dish, notice: "Edição do Prato Efetuada com sucesso."  
    else
      @traits = Trait.all
      flash.now[:notice] = 'Não foi possível editar o prato.'
      render :edit, status: :unprocessable_entity
    end
  end

  def index
    @dishes = current_user.store.dishes
  end

  def destroy
    if @dish.destroy!
      redirect_to dishes_path, notice: 'Prato deletado com sucesso'
    end
  end

  def inactive
    @dish.inactive!
    redirect_to @dish, notice: 'Status do Prato atualizado com sucesso.'
  end

  def active
    @dish.active!
    redirect_to @dish, notice: 'Status do Prato atualizado com sucesso.'
  end

  private
  def dish_params
    params.require(:dish).permit(:name, :description, :calories, :photo)
  end

  def set_dish_and_check_owner
    @dish = Dish.find params[:id]
    if @dish.store != current_user.store
      redirect_to root_path 
    end
  end
end