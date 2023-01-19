# frozen_string_literal: true

class Appointment < ApplicationRecord
  include AASM

  belongs_to :doctor
  belongs_to :user

  validates :doctor_id, :user_id, :appointment_date, presence: true
  validates :symptoms, presence: true, length: { in: 5..500 }
  validates :recommendation, length: { in: 5..500 }, on: :update
  validates_with AppointmentValidator

  default_scope -> { order(created_at: :desc) }
  scope :opened, -> { where(aasm_state: :opening).order(created_at: :desc) }
  scope :closed, -> { where(aasm_state: :closing).order(created_at: :desc) }

  aasm do
    state :opening, initial: true
    state :closing

    event :open do
      transitions from: :closing, to: :opening
    end

    event :close do
      transitions from: :opening, to: :closing
    end
  end
end
