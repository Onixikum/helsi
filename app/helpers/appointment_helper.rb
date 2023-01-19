# frozen_string_literal: true

module AppointmentHelper
  def free_appointments(doctor)
    10 - doctor.appointments.where(aasm_state: :opening).count
  end
end
