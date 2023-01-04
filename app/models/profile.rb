# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :person, polymorphic: true
end
