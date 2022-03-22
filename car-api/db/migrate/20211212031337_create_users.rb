# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :nickname, null: false, unique: true
      t.string :email, unique: true, null: false
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
