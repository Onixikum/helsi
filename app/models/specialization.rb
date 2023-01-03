# frozen_string_literal: true

class Specialization < ApplicationRecord
  belongs_to :doctor
  belongs_to :category
end
