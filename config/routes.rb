Rails.application.routes.draw do
  get "reports/index"
  get "dashboard/index"
  # Login Routes
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"

  # Logout Route
  delete "/logout", to: "sessions#destroy"

  # Temporary Home Page
  root "sessions#new"

  # Dashboard
  get "/dashboard", to: "dashboard#index"

  # Course Module
  resources :courses
  # Teachers Module
  resources :teachers
  # Student Module
  resources :students
  # Fees Module
  resources :fees
  # Reports Module
  resources :reports, only: [ :index ]
end
