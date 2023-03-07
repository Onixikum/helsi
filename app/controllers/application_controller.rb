# frozen_string_literal: true

class ApplicationController < ActionController::Base
  add_flash_types :info, :error, :success

  protect_from_forgery

  check_authorization unless: :devise_or_active_admin?

  require 'will_paginate/array'

  rescue_from CanCan::AccessDenied do |exception|
    if current_user.nil?
      session[:next] = request.fullpath
      redirect_to root_url, alert: 'You have to log in to continue.'
    else
      respond_to do |format|
        format.json { render nothing: true, status: :not_found }
        format.html { redirect_to root_url, alert: exception.message }
        format.js   { render nothing: true, status: :not_found }
      end
    end
  end

  protected

  def devise_or_active_admin?
    devise_controller? || active_admin_resource?
  end

  def active_admin_resource?
    self.class.ancestors.include? ActiveAdmin::BaseController
  end
end
