class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :address
      t.string :address_line_two
      t.integer :number
      t.string :district
      t.string :city
      t.string :state
      t.string :description
      t.string :zip_code

      t.belongs_to :customer, index: { unique: true }, foreign_key: true
      t.timestamps
    end
  end
end
