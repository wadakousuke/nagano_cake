class Public::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def item_params
    params.permit(:name, :introduction, :price, :item_image,)
  end

end
