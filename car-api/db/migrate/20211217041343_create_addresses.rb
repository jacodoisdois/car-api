class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.integer :number
      t.string :address
      t.string :district
      t.integer :zip_code
      t.string :state
      t.string :city

      t.timestamps
    end
  end
end
