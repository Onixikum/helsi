# frozen_string_literal: true

ActiveAdmin.register Specialization do
  filter :doctor
  filter :category
  filter :created_at

  index do
    selectable_column
    id_column
    column :doctor
    column :category
    actions
  end

  controller do
    private

    def specialization_params
      params.require(:specialization).permit(:doctor_id, :category_id)
    end
  end
end
