# frozen_string_literal: true

class Doctor < ApplicationRecord
  before_save :normalize_phone

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include ExcludeEmail
  include PhoneNumber

  has_one :profile, as: :person, dependent: :destroy
  has_many :specializations, dependent: :destroy
  has_many :categories, through: :specializations
  has_many :appointments
  has_many :user, through: :appointments

  accepts_nested_attributes_for :profile

  validates :phone, presence: true, uniqueness: true
  validates :encrypted_password, presence: true
  validates :phone, phone: true

  default_scope -> { order(created_at: :desc) }

  def full_name
    [profile.first_name, profile.last_name].join(' ')
  end
end
