Rails.application.routes.draw do
  get "admin_profiles/show"
  get "admin_profiles/edit"
  resources :notifications
  # Login Routes
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"

  delete "/logout", to: "sessions#destroy"

  root "sessions#new"

  get "/dashboard", to: "dashboard#index"

  resources :courses
  resource :admin_profile, only: [ :show, :edit, :update ]
  resources :teachers
  resources :students
  resources :admins, only: [ :new, :create ]
  resources :fees
  resources :reports, only: [ :index ]
  resources :attendances do
    collection do
      get :workspace
    end
  end
  resources :notifications, only: [ :index, :show ]
end
