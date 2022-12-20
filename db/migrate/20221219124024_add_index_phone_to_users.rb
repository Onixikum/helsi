# frozen_string_literal: true

class AddIndexPhoneToUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :email
    remove_column :users, :phone
    add_column :users, :phone, :string, default: '', null: false
    add_index :users, :phone, unique: true
  end
end
