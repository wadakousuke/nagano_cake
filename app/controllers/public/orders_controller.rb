class Public::OrdersController < ApplicationController
  def new
    @order = Order.new(order_params)
    @customer = Customer.find(current_customer.id)
  end

  def confirm
     @order = Order.new(order_params)
     @customer = Customer.find(current_customer.id)

     if params[:select_address] == "0"
      @order.delivery_postal_code = current_customer.postal_code
      @order.delivery_postal_address = current_customer.address
      @order.delivery_postal_name = current_customer.first_name + current_customer.last_name
      binding.pry

     elsif params[:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.delivery_postal_code = @address.postal_code
      @order.delivery_postal_address = @address.address
      @order.delivery_postal_name = @address.name
      binding.pry
     elsif params[:select_address] == "2"
        session[:delivery_postal_code] = order_params[:delivery_postal_code]
        session[:delivery_postal_address] = order_params[:delivery_postal_address]
        session[:delivery_postal_name] = order_params[:delivery_postal_name]
        # shipping_addressesのインスタンス（外部キーにclient＿idが入ってる）を作成
        @address = @customer.addresses.build
        # shipping_addressesテーブルに保存
        @address.postal_code = order_params[:delivery_postal_code]
        @address.address = order_params[:delivery_postal_addressstreet_address]
        @address.name = order_params[:delivery_postal_namereceive_name]
        if @address.save
          flash[:success] = "新しいお届け先が保存されました"
          redirect_to orders_confirm_order_path
        else
          flash[:danger] = "新しいお届け先の情報を正しく入力してください"
          redirect_back(fallback_location: root_path)
        end
     else # どのラジオボタンも選択されていないときは同じページに返す
        flash[:danger] = "必要情報を入力してください"
        redirect_back(fallback_location: root_path)
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
      params.permit(:customer_id, :delivery_postal_code, :delivery_postal_address, :delivery_postal_name, :shipping_cost, :billing_information, :payment_method)
  end
end
