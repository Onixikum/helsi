# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include ExcludeEmail

  has_one :profile, as: :person, dependent: :destroy

  accepts_nested_attributes_for :profile

  validates :phone, presence: true, uniqueness: true

  default_scope -> { order(created_at: :desc) }
end
