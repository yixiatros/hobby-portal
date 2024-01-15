# frozen_string_literal: true

Rails.application.routes.draw do

  get 'log_in', to: 'sessions#login'
  post 'log_in', to: 'sessions#create'
  get 'sign_up', to: 'registrations#register'
  post 'sign_up', to: 'registrations#create'
  delete 'logout', to: 'sessions#destroy'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  get 'home/index'
  root 'home#index'
end
