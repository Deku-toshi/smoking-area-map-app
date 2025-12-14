Rails.application.routes.draw do
  namespace :v1 do
    resources :tobacco_types, only: [:index]
    resources :smoking_areas, only: %i[index show]
  end

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
