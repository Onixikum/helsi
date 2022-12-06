# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
