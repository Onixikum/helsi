# frozen_string_literal: true

module Users
  class DoctorsController < BaseController
    authorize_resource

    def show
      @doctor = Doctor.find_by(id: params[:doctor_id])
      @categories = @doctor.categories
      @appointment = current_user.appointments.new
      @appointments = current_user.appointments.opened.where(
        doctor_id: params[:doctor_id]
      ).paginate(page: params[:page], per_page: 5)
    end

    private

    def doctor_params
      params.require(:doctor).permit(:doctor_id)
    end
  end
end
