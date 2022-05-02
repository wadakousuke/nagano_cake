class Admin::OrdersController < ApplicationController
     before_action :authenticate_admin!
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    if @order.status == "payment_confirmation"
      @order_details = @order.order_details.all
     @order_details.each do |i|
      i.making_status = 1
     i.update(order_detail_params)
     end
       redirect_to admin_order_path
    end
  end

  def index
    @orders = Order.all

  end

  private

  def order_params
     params.require(:order).permit(:status)
  end

  def order_detail_params
     params.permit(:making_status)
  end
end
