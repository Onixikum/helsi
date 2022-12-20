# frozen_string_literal: true

class AddPhoneToAdminUsers < ActiveRecord::Migration[7.0]
  def change
    remove_index :admin_users, :email
    remove_column :admin_users, :email
    add_column :admin_users, :phone, :string, default: '', null: false
    add_index :admin_users, :phone, unique: true
  end
end
