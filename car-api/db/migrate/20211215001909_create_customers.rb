class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.bigint :social_security
      t.date :date_birth, null: false
      t.date :last_time_purchase

      t.timestamps
    end
  end
end
