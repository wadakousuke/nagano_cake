# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController


  before_action :customer_state, only: [:create]
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :telephone_number])
  end

  def customer_state
  ## 【処理内容1】 入力されたemailからアカウントを1件取得
  @customer = Customer.find_by(email: params[:customer][:email])
  ## アカウントを取得できなかった場合、このメソッドを終了する
  return if !@customer
  ## 【処理内容2】 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
   if @customer.valid_password?(params[:customer][:password])
    ## 【処理内容3】
     if @customer.is_deleted && !true
        render action: :create
     elsif @customer.is_deleted && true
        redirect_to  new_customer_registration_path
     end
   end

  end
end
