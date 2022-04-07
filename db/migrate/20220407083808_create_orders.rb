class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|

      t.timestamps
      t.references :customer, foreign_key: true, :null => false
      t.string :delivery_postal_code, :null => false
      t.string :delivery_postal_address, :null => false
      t.string :delivery_postal_name, :null => false
      t.integer :shipping_cost, :null => false
      t.integer :billing_information, :null => false
      t.integer :payment_method, :null => false, :default => '0'
      t.integer :status, :null => false, :default => '0'
    end
  end
end
