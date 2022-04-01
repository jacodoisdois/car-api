class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.belongs_to :customer, null: false, foreign_key: true
      t.decimal :total, null: false, default: 0

      t.timestamps
    end
  end
end
