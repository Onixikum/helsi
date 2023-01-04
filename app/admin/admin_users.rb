# frozen_string_literal: true

ActiveAdmin.register AdminUser do
  permit_params :phone, :password, :password_confirmation

  filter :phone
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  index do
    selectable_column
    id_column
    column :phone
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end
end
