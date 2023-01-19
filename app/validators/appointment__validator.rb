# frozen_string_literal: true

class AppointmentValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add(:aasm_state, 'This doctor has no free appointment!') unless doctor_is_free?(record)
  end

  def doctor_is_free?(appointment)
    appointment.doctor.appointments.where(aasm_state: :opening).count < 10
  end
end
