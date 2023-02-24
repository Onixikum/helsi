# frozen_string_literal: true

module Users
  class AppointmentsController < BaseController
    authorize_resource

    def index
      @close_appointments = current_user.appointments.closed.paginate(page: params[:page], per_page: 5)
    end

    def create
      @appointment = current_user.appointments.new(appointment_params)
      if @appointment.save
        flash[:success] = "A doctor's appointment has been created!"
        redirect_to user_root_path
      else
        flash[:error] = 'Something went wrong! Choose a doctor and describe your symptoms.'
        redirect_to users_categories_path
      end
    end

    private

    def appointment_params
      params.require(:appointment).permit(:doctor_id, :appointment_date, :symptoms)
    end
  end
end
