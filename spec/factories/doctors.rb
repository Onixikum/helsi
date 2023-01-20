# frozen_string_literal: true

FactoryGirl.define do
  factory :doctor do
    phone { "+38063#{Faker::Number.number(digits: 7)}" }
    password { 'password' }

    after(:create) do |doctor|
      create(:profile, person: doctor)
    end
  end
end
