# frozen_string_literal: true

class ApplicationController < ActionController::Base
  add_flash_types :info, :error, :success
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:phone, :password, :password_confirmation)
    end
  end
end
