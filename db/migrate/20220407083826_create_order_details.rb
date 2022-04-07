class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|

      t.timestamps
      t.references :item, foreign_key: true, :null => false
      t.references :order, foreign_key: true, :null => false
      t.string :price_including_tax, :null => false
      t.integer :amount, :null => false
      t.integer :making_status, :null => false, :default => '0'

    end
  end
end
