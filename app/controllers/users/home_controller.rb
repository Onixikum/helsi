# frozen_string_literal: true

module Users
  class HomeController < BaseController
    def show
      authorize! :read, :show
      @open_appointments = current_user.appointments.opened.paginate(page: params[:page], per_page: 5)
    end
  end
end
