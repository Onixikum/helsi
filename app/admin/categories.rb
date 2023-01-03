# frozen_string_literal: true

ActiveAdmin.register Category do
  filter :name
  filter :created_at

  index do
    selectable_column
    id_column
    column :name
    column('Count of doctors') { |categoty| categoty.doctors.count }
    actions
  end
end
