class Public::CustomersController < ApplicationController
   before_action :authenticate_customer!
  def my_page


  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to my_page_path
  end

  def unsubscribe
  end

  def withdraw
    @customer = Customer.find(current_customer.id)
    @customer.is_deleted = true
    @customer.update(customer_params)
    reset_session
    redirect_to root_path
  end

  private
  def customer_params
    params.permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :telephone_number, :address, :is_deleted, :email)
  end
end
