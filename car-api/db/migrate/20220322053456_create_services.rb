class CreateServices < ActiveRecord::Migration[6.1]
  def change
    create_table :services do |t|
      t.string :title
      t.decimal :price
      t.text :description
      t.integer :duration

      t.timestamps
    end
  end
end
