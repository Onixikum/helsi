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

  controller do
    private

    def category_params
      params.require(:category).permit(:name)
    end
  end
end
