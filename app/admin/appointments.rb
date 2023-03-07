# frozen_string_literal: true

ActiveAdmin.register Appointment do
  filter :doctor
  filter :user
  filter :aasm_state
  filter :created_at

  index do
    selectable_column
    id_column
    column :doctor
    column :user
    column :aasm_state
    actions
  end
end
