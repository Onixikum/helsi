# frozen_string_literal: true

class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
  include ExcludeEmail

  validates :phone, presence: true, uniqueness: true
  validates :encrypted_password, presence: true
end
