class Public::AddressesController < ApplicationController
  def index
    @address = Address.new
    @addresses =  Address.all
  end

  def edit
  end

  def create
    @address = Address.new(params[:id])
    @address.customer_id = current_customer.id
  end

  def update
  end

  def destroy
  end

private

  def address_params
      params.permit(:customer_id, :postal_code, :address, :name)
  end

end
