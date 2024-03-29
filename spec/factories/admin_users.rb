# frozen_string_literal: true

FactoryBot.define do
  factory :admin_user do
    phone { "+38063#{Faker::Number.number(digits: 7)}" }
    password { 'password' }
  end
end
