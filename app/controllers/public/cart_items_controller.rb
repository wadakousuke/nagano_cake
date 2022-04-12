class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
  end

  def update
  end

  def destroy
  end

  def empty
  end

  def create
    @cart_item = Item.new(cart_item_params)
    @cart_item.save
    redirect_to cart_items_path
  end
private
  def cart_item_params
      params.permit(:item_id, :amount)
  end
end
