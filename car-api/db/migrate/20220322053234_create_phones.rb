class CreatePhones < ActiveRecord::Migration[6.1]
  def change
    create_table :phones do |t|
      t.string :country_code
      t.string :local_code
      t.bigint :number
      
      t.belongs_to :customer, index: { unique: true }, foreign_key: true
      t.timestamps
    end
  end
end
