# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :person, polymorphic: true

  validates :first_name, presence: true
  validates :last_name, presence: true
end
