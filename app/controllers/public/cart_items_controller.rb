class Public::CartItemsController < ApplicationController
  def index
  end

  def update
  end

  def destroy
  end

  def empty
  end

  def create
    @cart_items = Item.new(cart_item_params)
    binding.pry
    @cart_items.save
    redirect_to cart_items_path
  end
private
  def cart_item_params
      params.permit(:item_id, :amount)
  end
end
