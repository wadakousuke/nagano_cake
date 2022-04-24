class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = Customer.find(current_customer.id)
  end

  def confirm
     @order = Order.new(order_params)
     @customer = Customer.find(current_customer.id)

    if params[:select_address] == "0"
      @order.delivery_postal_code = current_customer.postal_code
      @order.delivery_postal_address = current_customer.address
      @order.delivery_postal_name = current_customer.first_name + current_customer.last_name

    elsif params[:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.delivery_postal_code = @address.postal_code
      @order.delivery_postal_address = @address.address
      @order.delivery_postal_name = @address.name
    elsif params[:select_address] == "2"

    end

     @cart_items = CartItem.all
     @total = 0
     @order.shipping_cost = 800
     @order.billing_information = @order.shipping_cost + @total

  end



  def create
    @order = Order.new(order_params)
    @order.save
     @order.customer.cart_items.each do |i|
        @order_detail = OrderDetail.new(order_detail_params)
        @order_detail.order_id = @order.id
        @order_detail.making_status = 0
        @order_detail.item_id = i.item_id
        @order_detail.amount = (i.amount).to_i
        @order_detail.price_including_tax = (i.item.price * 1.1).to_i
        @order_detail .save
        current_customer.cart_items.destroy_all
        redirect_to  controller: :orders, action: :complete

      end

  end

  def complete
  end

  def index
    @orders = current_customer.orders.all
  end


  def show
    @order = Order.find(params[:id])
    @order_detail = OrderDetail.find(@order.id)
    @oreder_items = Item.find(@order_detail.item_id)

    # 下記３行は商品合計を出すため

  end


private

  def order_params
     params.require(:order).permit(:customer_id,:delivery_postal_code, :delivery_postal_address, :delivery_postal_name,:payment_method, :shipping_cost, :billing_information)
  end

  def order_detail_params
    params.permit(:item_id,:order_id, :price_including_tax, :amount,:making_status)
  end

end
