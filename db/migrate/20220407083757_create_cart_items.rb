class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|

      t.timestamps
      t.references :customer, foreign_key: true, :null => false
      t.references :item, foreign_key: true, :null => false
      t.integer :amount, :null => false

    end
  end
end
