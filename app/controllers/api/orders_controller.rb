class Api::OrdersController < ActionController::API
  def index 
    if params[:status]
      orders = Store.find_by(code: params[:code]).orders.where(status: params[:status])
      return render status: 200, json: orders 
    end

    orders = Store.find_by(code: params[:code]).orders
    render status: 200, json: orders 
  end

  def show 
    store = Store.find_by(code: params[:code])
    order = store.orders.find_by(code: params[:id])
    order_object = {order: order, store: store}
    render status: 200, json: order_object 
  end
end