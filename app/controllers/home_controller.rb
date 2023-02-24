# frozen_string_literal: true

class HomeController < ApplicationController
  skip_authorization_check

  def welcome
    redirect_to user_root_path if current_user
    redirect_to doctor_root_path if current_doctor
  end
end
