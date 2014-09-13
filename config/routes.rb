Rails.application.routes.draw do
  root to: "projects#index"

  resources :equipment
  resources :projects
end

