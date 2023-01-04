# frozen_string_literal: true

class Specialization < ApplicationRecord
  belongs_to :doctor
  belongs_to :category

  validates_uniqueness_of :doctor_id, scope: :category_id, message: 'Doctors can only have a category one time!'
end
