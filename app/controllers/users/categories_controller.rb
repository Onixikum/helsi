# frozen_string_literal: true

module Users
  class CategoriesController < BaseController
    def index
      @categories = Category.paginate(page: params[:page], per_page: 10)
    end

    def show
      @category = Category.find_by(id: params[:id])
      @doctors = @category.doctors.paginate(page: params[:page], per_page: 10)
    end
  end
end
