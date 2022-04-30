class Public::ItemsController < ApplicationController
   before_action :authenticate_customer!, except: [:index]

  def index
    @items = Item.page(params[:page]).per(8)
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

private
  def item_params
    params.permit(:name, :introduction, :price, :item_image,)
  end

end
