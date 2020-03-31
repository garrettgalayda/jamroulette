# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'static#beta'
  post '/validate_beta_user', to: 'static#validate_beta_user'
  get 'home', to: 'static#index'

  get '/rooms/random', to: redirect { "/rooms/#{Room.random_id}" }

  resources :rooms, only: %i[create show] do
    resources :jams, only: :create
  end
end
