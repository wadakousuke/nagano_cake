class Admin::OrderDetailsController < ApplicationController
    before_action :authenticate_admin!
  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
    @order_details.each do |i|
    i.update(order_detail_params)
  end

   @order_detail = @order.order_details
  @order_details.each do |i|
  if i.making_status == "in_production"
     @order.status = 2
     @order.update(order_params)
  end
  end
   redirect_to admin_order_path
  end

  private

  def order_detail_params
     params.require(:order_detail).permit(:making_status)
  end
  def order_params
     params.permit(:status)
  end
end
