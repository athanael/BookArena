Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Page d'accueil
  root to: 'pages#home'

  resources :arenas, only: [:index, :show, :new, :create, :destroy]
  # Defines the root path route ("/")
  # root "posts#index"
  # Routes pour les arènes avec les actions index et show
  resources :arenas do
    resources :bookings, only: [:index, :show, :new, :create]
  end
end
