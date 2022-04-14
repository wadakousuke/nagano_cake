class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy

  #    カートアイテムの追加
  def add_item(item_id:, amount:)
    # カートに入っていない商品を追加する場合はItemレコードを新規作成
    cart_item = cart_items.find_by(item_id: item_id) || cart_items.build(item_id: item_id)
    cart_item.amount += amount.to_i
    cart_item.save
  end

  #    カートアイテムの更新
  def update_item(item_id:, amount:)
    cart_items.find_by(item_id: item_id).update(amount: amount.to_i)
  end

  #    カートアイテムの削除
  def delete_item(item_id:)
    cart_items.find_by(item_id: item_id).destroy
  end

  #    カートの合計の算出
  def total_price
    cart_items.sum("amount*price")
  end
end
