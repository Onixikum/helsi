# frozen_string_literal: true

class Persons::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def new
    build_resource({})
    resource.build_profile
    respond_with resource
  end

  protected

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up) do |person|
      person.permit(permitted_attributes_for_registration)
    end
  end

  def configure_sign_up_params
    devise_parameter_sanitizer
      .permit(:sign_up, keys: permitted_attributes_for_registration)
  end

  def permitted_attributes_for_registration
    [
      :phone,
      :password,
      :password_confirmation,
      :remember_me,
      profile_attributes: %i[first_name last_name]
    ]
  end
end
