Rails.application.routes.draw do
  resources :locations

  post "/android_locations", to: "locations#android_locations"

  root to: "projects#index"

  resources :equipment
  resources :projects
end

