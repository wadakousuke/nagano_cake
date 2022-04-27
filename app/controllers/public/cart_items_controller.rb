class Public::CartItemsController < ApplicationController
   def index
    @total = 0
    @cart_items = CartItem.all
   end

  def new
    @cart_item = CartItem.new(cart_item_params)
  end

  def create
    @cart_items = CartItem.new(cart_item_params)
    @cart_items.customer_id = current_customer.id

   if  @cart_items.save
      flash[:notice] = '商品が追加されました。'
      redirect_to cart_items_path
   else
      flash[:alert] = '商品の追加に失敗しました。'
      redirect_to cart_items_path
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
    cart_item = CartItem.all
    cart_item.destroy_all
    redirect_to cart_items_path
  end

private

  def cart_item_params
      params.permit(:item_id, :amount, :customer_id)
  end
end