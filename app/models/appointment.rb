# frozen_string_literal: true

class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :user

  validates :doctor_id, :user_id, :appointment_date, presence: true
end
