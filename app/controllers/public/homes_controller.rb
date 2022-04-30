class Public::HomesController < ApplicationController
    before_action :authenticate_customer!, except: [:top, :about]
  def top
    @genres = Genre.all
    @items = Item.order(created_at: :desc).limit(4)
  end

  def about
  end
end
