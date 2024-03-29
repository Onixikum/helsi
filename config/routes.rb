# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#welcome'
  get 'users/home/show',   as: 'user_root'
  get 'doctors/home/show', as: 'doctor_root'

  namespace :users do
    resources :categories, only: %i[index show]
    resources :appointments, only: %i[index create]
    resources :doctors, only: :show
  end

  namespace :doctors do
    resources :appointments, only: %i[index update]
    resources :users, only: %i[show index] do
      collection do
        get 'history'
      end
    end
  end

  devise_for :users, controllers: {
    registrations: 'persons/registrations'
  }

  devise_for :doctors, controllers: {
    registrations: 'persons/registrations'
  }

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
