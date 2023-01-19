# frozen_string_literal: true

require 'faker'

FactoryGirl.define do
  factory :specialization do
    doctor
    category
  end
end
