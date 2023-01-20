# frozen_string_literal: true

FactoryGirl.define do
  factory :appointment do
    doctor
    user
    appointment_date { DateTime.now }
    symptoms { Faker::Lorem.paragraph_by_chars }

    trait :closing do
      recommendation { Faker::Lorem.paragraph_by_chars }
      aasm_state :closing
    end
  end
end
