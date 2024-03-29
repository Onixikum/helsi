# frozen_string_literal: true

module Doctors
  class UsersController < BaseController
    authorize_resource

    def index
      @patients = current_doctor.appointments.opened.map(&:user).uniq.paginate(page: params[:page], per_page: 5)
    end

    def show
      @open_appointments = user.appointments.opened.paginate(page: params[:page], per_page: 5)
    end

    def history
      @close_appointments = user.appointments.closed.paginate(page: params[:page], per_page: 5)
    end

    private

    def user
      @user ||= User.find_by(id: params[:id])
    end
  end
end
