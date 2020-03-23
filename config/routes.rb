# frozen_string_literal: true

Rails.application.routes.draw do
  root 'static#index'

  resources :rooms, only: [:create]
  get 'rooms/:room_hash', to: 'rooms#show', as: 'room'
  patch 'rooms/:room_hash', to: 'rooms#update'
end
