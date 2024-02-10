# frozen_string_literal: true

Rails.application.routes.draw do
  get 'notifications', to: 'notifications#index'

  resources :rooms do
    resources :messages
  end

  resources :users

  get '/search/:search_term', to: 'posts#search_post'

  get 'rooms', to: 'rooms#index'
  post 'rooms/create', to: 'rooms#create'

  get 'contacts', to: 'contacts#index'
  post 'contacts/add', to: 'contacts#add'

  get 'posts', to: 'posts#index'
  post 'post', to: 'posts#create'

  get 'password/reset', to: 'password_resets#new'
  post 'password/reset', to: 'password_resets#create'
  get 'password/reset/edit', to: 'password_resets#edit'
  patch 'password/reset/edit', to: 'password_resets#update'
  get 'password', to: 'passwords#edit', as: :edit_password
  patch 'password', to: 'passwords#update'

  get '/auth/:provider/callback', to: 'sessions#omniauth'
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
