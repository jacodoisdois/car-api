class CreateCars < ActiveRecord::Migration[6.1]
  def change
    create_table :cars do |t|
      t.string :model
      t.string :brand
      t.string :color
      t.integer :year

      t.belongs_to :customer, index: { unique: true }, foreign_key: true
      t.timestamps
    end
  end
end
