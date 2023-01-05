# frozen_string_literal: true

class AddAttributesToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :symptoms, :string
    add_column :appointments, :recommendation, :string
  end
end
