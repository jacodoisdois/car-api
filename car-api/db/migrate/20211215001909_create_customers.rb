class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :name, null: false
      t.string :email, null: false, index: { unique: true }
      t.bigint :social_security_number
      t.date :birth_date, null: false
      t.date :last_purchase_date

      t.timestamps
    end
  end
end
