# frozen_string_literal: true

FactoryGirl.define do
  factory :specialization do
    doctor
    category
  end
end
