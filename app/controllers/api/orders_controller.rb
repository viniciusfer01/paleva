class Api::OrdersController < ActionController::API
  def index 
    if params[:status]
      orders = Store.find_by(code: params[:code]).orders.find_by(status: params[:status])
      return render status: 200, json: orders 
    end

    orders = Store.find_by(code: params[:code]).orders
    render status: 200, json: orders 
  end
end