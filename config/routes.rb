Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: "pages#home"

  get "up" => "rails/health#show", as: :rails_health_check

  resources :arenas, only: [:index, :show] do
    resources :bookings, only: [:index]
  end
end
