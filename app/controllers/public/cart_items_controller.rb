class Public::CartItemsController < ApplicationController
   before_action :authenticate_customer!
   def index
    @total = 0
    @cart_items = CartItem.all

   end

  def new
    @cart_item = CartItem.new(cart_item_params)
  end

  def create

    @cart_items = current_customer.cart_items.all
    if cart_item_params[:amount] != ""
      if @cart_items.any? { |cart_item| cart_item.item_id == params[:item_id].to_i }
        @cart_items_already = CartItem.find_by(item_id: params[:item_id].to_i)
        @cart_items_already.amount += params[:amount].to_i
        @cart_items_already.save
        flash[:success] = "カートに商品を入れました"
        redirect_to cart_items_path
      else
        @cart_items = CartItem.new(cart_item_params)
        @cart_items.customer_id = current_customer.id
        @cart_items.save
        flash[:notice] = '商品が追加されました。'
        redirect_to cart_items_path
      end
    end

  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def all
    @cart_item = CartItem.all
    @cart_item.destroy_all
    redirect_to cart_items_path
  end

private

  def cart_item_params
      params.permit(:item_id, :amount, :customer_id)
  end
end