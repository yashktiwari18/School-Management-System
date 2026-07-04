Rails.application.routes.draw do
  # Login Routes
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"

  delete "/logout", to: "sessions#destroy"

  root "sessions#new"

  get "/dashboard", to: "dashboard#index"

  resources :courses
  resources :teachers
  resources :students
  resources :fees
  resources :reports, only: [ :index ]
  resources :attendances
end
