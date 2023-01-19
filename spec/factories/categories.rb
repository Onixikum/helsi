# frozen_string_literal: true

require 'faker'

FactoryGirl.define do
  factory :category do
    name { 'Family medicine' }
  end
end
