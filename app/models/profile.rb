# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :person, polymorphic: true

  def full_name
    [first_name, last_name].join(' ')
  end
end
