class OrdersController < ApplicationController
  before_action :authenticate_user_or_employee!
  def new
    @order = Order.new
    @dishes = Dish.all
    @beverages = Beverage.all
  end

  def create
    @order = Order.new(order_params)
    @order.price = calculate_total_price
    @order.store = current_user.store
    @order.user = current_user

    if @order.save
      redirect_to order_path(@order.id), notice: 'Pedido gravado com sucesso'
    else
      flash.now[:notice] = 'Não foi possível registrar seu pedido'
      render :new, status: :unprocessable_entity
    end
  end

  def show 
    @order = current_user.orders.find(params[:id])
  end

  def index 
    @orders = current_store.orders.includes(:order_items => [:portion])
  end
  private
  def order_params
    params.require(:order).permit(:name, :phone, :email, :cpf, order_items_attributes: [:portion_id, :note])
  end

  def calculate_total_price
    @order.order_items.sum { |item| item.portion.price/100.0 }
  end

  def current_store
    if user_signed_in?
      current_user.store
    elsif employee_signed_in?
      current_employee.store
    end
  end
end