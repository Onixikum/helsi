# frozen_string_literal: true

ActiveAdmin.register User do
  filter :phone
  filter :created_at

  index do
    selectable_column
    id_column
    column :full_name
    column :phone
    actions
  end

  show do
    attributes_table do
      row :full_name
      row :phone
      row :created_at
      row :update_at
    end
    active_admin_comments
  end

  form do |f|
    f.inputs do
      f.inputs do
        f.has_many :profile, allow_destroy: true do |t|
          t.input :first_name
          t.input :last_name
        end
      end
      f.input :phone
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
