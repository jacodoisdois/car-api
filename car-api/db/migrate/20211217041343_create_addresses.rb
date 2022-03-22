class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :address
      t.integer :number
      t.string :district
      t.string :city
      t.string :state
      t.integer :zip_code

      t.timestamps
    end
  end
end
