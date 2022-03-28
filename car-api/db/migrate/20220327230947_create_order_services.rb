class CreateOrderServices < ActiveRecord::Migration[6.1]
  def change
    create_table :order_services do |t|
      t.belongs_to :order, null: false, foreign_key: true
      t.belongs_to :service, null: false, foreign_key: true

      t.integer :service_duration, null: false
      t.datetime :scheduled_time, null: false

      t.timestamps
    end
  end
end
