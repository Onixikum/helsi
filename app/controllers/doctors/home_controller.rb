# frozen_string_literal: true

module Doctors
  class HomeController < BaseController
    def show
      @open_appointments = current_doctor.appointments.opened.paginate(page: params[:page], per_page: 5)
      @categories = current_doctor.categories
    end
  end
end
