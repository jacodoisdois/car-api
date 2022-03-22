class CreatePhones < ActiveRecord::Migration[6.1]
  def change
    create_table :phones do |t|
      t.string :country_code
      t.string :local_code
      t.string :number

      t.timestamps
    end
  end
end
