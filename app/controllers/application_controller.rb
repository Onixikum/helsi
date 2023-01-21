# frozen_string_literal: true

class ApplicationController < ActionController::Base
  add_flash_types :info, :error, :success

  require 'will_paginate/array'
end
