Rails.application.routes.draw do
  get "request/create"
  get "pages/home"
  get "pages/dashboard"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "pages#home"

  get "home" => "pages#home", as: :home
  get "userdashboard" => "pages#user_dashboard", as: :user_dashboard
  get "globaldashboard" => "pages#global_dashboard", as: :global_dashboard

  post "simulate_requests", to: "requests#simulate_requests", as: :simulate_requests

  delete "clear_requests", to: "requests#clear_requests", as: :clear_requests


  resources :requests, only: [ :create ]
end
