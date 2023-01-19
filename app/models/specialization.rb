# frozen_string_literal: true

class Specialization < ApplicationRecord
  belongs_to :doctor
  belongs_to :category

  validates :doctor_id, presence: true
  validates :category_id, presence: true
  validates_uniqueness_of :doctor_id, scope: :category_id
end
