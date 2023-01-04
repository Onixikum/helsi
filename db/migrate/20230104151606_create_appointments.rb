# frozen_string_literal: true

class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.belongs_to :doctor
      t.belongs_to :user
      t.datetime :appointment_date

      t.timestamps
    end
  end
end
