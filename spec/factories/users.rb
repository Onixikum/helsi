# frozen_string_literal: true

require 'faker'

FactoryGirl.define do
  factory :user do
    phone { "+38063#{Faker::Number.number(digits: 7)}" }
    password { 'password' }

    after(:create) do |user|
      create(:profile, person: user)
    end
  end
end
