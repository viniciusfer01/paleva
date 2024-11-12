class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.name = current_user.name
    @order.price = 0
    @order.store = current_user.store
    @order.user = current_user
    @order.email = current_user.email
    @order.cpf = current_user.cpf

    if @order.save
      redirect_to order_path(@order.id), notice: 'Pedido iniciado com sucesso'
    else
      flash.now[:notice] = 'Não foi possível registrar seu pedido'
      render :new, status: :unprocessable_entity
    end
  end

  def show 
    @order = current_user.orders.find(params[:id])
  end

  private
  def order_params
    params.require(:order).permit(:phone)
  end
end