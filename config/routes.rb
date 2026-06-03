Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "dashboard#index"

  get    "login",    to: "sessions#new",     as: :login
  post   "login",    to: "sessions#create"
  delete "logout",   to: "sessions#destroy", as: :logout
  get    "register", to: "users#new",        as: :register
  post   "register", to: "users#create"

  resource :profile, only: [:edit, :update], controller: "users"

  resources :tasks do
    member { patch :complete }
  end

  resources :achievements, only: [:index]

  patch "theme", to: "themes#update", as: :theme
end
