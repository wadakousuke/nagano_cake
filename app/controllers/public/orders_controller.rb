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
      binding.pry
    elsif params[:select_address] == "2"
      binding.pry
    end



  end

  def complete
  end

  def create
  end

  def index
  end


  def show
  end


private

  def order_params
     params.require(:order).permit(:delivery_postal_code, :delivery_postal_address, :delivery_postal_name,:payment_method)
  end

end
