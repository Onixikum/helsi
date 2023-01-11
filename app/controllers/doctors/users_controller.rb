# frozen_string_literal: true

module Doctors
  class UsersController < BaseController
    def show
      @user = User.find_by(id: params[:id])
      @open_appointments = @user.appointments.opened.paginate(page: params[:page], per_page: 5)
      @close_appointments = @user.appointments.closed.paginate(page: params[:page], per_page: 5)
    end
  end
end
