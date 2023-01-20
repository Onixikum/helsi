# frozen_string_literal: true

module Doctors
  class AppointmentsController < BaseController
    def index
      @appointments = current_doctor.appointments.closed.paginate(page: params[:page], per_page: 5)
      @categories = current_doctor.categories
    end

    def update
      if appointment.update(appointment_params)
        appointment.close!
        flash[:success] = 'Recommendations are provided!'
      else
        flash[:error] = 'Something went wrong! Choose an appointment and provide recommendations.'
      end

      redirect_to doctor_root_path
    end

    private

    def appointment
      @appointment ||= Appointment.find_by(id: params[:id])
    end

    def appointment_params
      params.require(:appointment).permit(:recommendation)
    end
  end
end
