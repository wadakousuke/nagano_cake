class ApplicationController < ActionController::Base

private
  def cart_item_params
      params.permit(:item_id, :amount)
  end
end
