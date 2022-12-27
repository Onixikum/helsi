# frozen_string_literal: true

module Doctors
  class BaseController < ApplicationController
    before_action :authenticate_doctor!
  end
end
