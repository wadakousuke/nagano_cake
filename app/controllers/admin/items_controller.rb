class Admin::ItemsController < ApplicationController
  def index

    @items = Item.all

  end

  def new
    @items = Item.new
  end

  def create
    @items = Item.new(item_params)
    @items.save
    redirect_to admin_items_path
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item= Item.find(params[:id])
    @item.update(item_params)
    redirect_to admin_item_path

  end

   private
  def item_params
    params.permit(:name, :introduction, :price, :is_active, :item_image, :genre_id)
  end

end
