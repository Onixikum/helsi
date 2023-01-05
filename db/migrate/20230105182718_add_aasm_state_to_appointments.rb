# frozen_string_literal: true

class AddAasmStateToAppointments < ActiveRecord::Migration[7.0]
  def change
    add_column :appointments, :aasm_state, :string
  end
end
