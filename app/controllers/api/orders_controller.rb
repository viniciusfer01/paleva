class Api::OrdersController < ActionController::API
  def index 
    store = Store.find_by(code: params[:code])

    if store.nil?
      return render status: 404, json: { error: 'Store not found' }
    end

    if params[:status]
      orders = store.orders.where(status: params[:status])
      return render status: 200, json: orders 
    end

    orders = store.orders

    if orders.any?
      return render status: 200, json: orders
    end
    
    render status: 404, json: { error: 'No orders found' }
  end

  def show 
    store = Store.find_by(code: params[:code])
    order = store.orders.find_by(code: params[:id])
    order_object = {order: order, store: store}
    render status: 200, json: order_object 
  end

  def prepping
    store = Store.find_by(code: params[:code])
    order = store.orders.find_by(code: params[:id])
    order.status = 'prepping'
    if order.save
      order_object = {order: order, store: store}
      render status: 200, json: order_object
    else 
      render status: 500
    end
  end

  def ready
    store = Store.find_by(code: params[:code])
    order = store.orders.find_by(code: params[:id])
    order.status = 'ready'
    if order.save
      order_object = {order: order, store: store}
      render status: 200, json: order_object
    else 
      render status: 500
    end
  end
end