class CreateOrderProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :order_products do |t|
      t.belongs_to :order, null: false, foreign_key: true
      t.belongs_to :product, null: false, foreign_key: true
      t.decimal :total, precision: 10, scale: 2
      t.integer :quantity, null: false

      t.timestamps
    end
  end
end
