Rails.application.routes.draw do
  resources :locations

  root to: "projects#index"

  resources :equipment
  resources :projects
end

