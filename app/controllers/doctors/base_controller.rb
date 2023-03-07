# frozen_string_literal: true

module Doctors
  class BaseController < ApplicationController
    before_action :authenticate_doctor!

    alias current_user current_doctor
  end
end
