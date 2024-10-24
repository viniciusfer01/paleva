class StoresController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def new
    @store = Store.new
  end

  def show
    @store = Store.find(params[:id])
  end

  def create
    @store = Store.new store_params
    @store.user = current_user

    if @store.save
      redirect_to @store, notice: 'Estabelecimento registrado com sucesso.'
    else
      flash.now[:notice] = 'Não foi possível registrar seu estabelecimento.'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  private 
  def store_params
    params.require(:store).permit(:brand_name, :corporate_name,  :cnpj,  :address,  :phone,  :email,  :schedule)
  end
end
