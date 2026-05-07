# frozen_string_literal: true

Rails.application.routes.draw do
  root 'static_pages#home'
  # sessions
  get 'sessions/new'
  # static pages
  get '/home', to: 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  # auth
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  # users
  resources :users
end
