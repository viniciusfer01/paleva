class Api::OrdersController < ActionController::API
  def index 
    orders = Store.find_by(code: params[:code]).orders
    render status: 200, json: orders 
  end
end