# frozen_string_literal: true

class Category < ApplicationRecord
  before_validation :normalize_name, on: %i[create update]

  has_many :specializations, dependent: :destroy
  has_many :doctors, through: :specializations

  validates :name, presence: true, uniqueness: true

  default_scope -> { order(name: :asc) }

  private

  def normalize_name
    self.name = name.downcase.titleize
  end
end
