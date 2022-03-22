class CreateCars < ActiveRecord::Migration[6.1]
  def change
    create_table :cars do |t|
      t.string :model
      t.string :brand
      t.int :year

      t.timestamps
    end
  end
end
