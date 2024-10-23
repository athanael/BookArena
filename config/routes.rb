Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Page d'accueil
  root to: 'pages#home'

  get 'arenas/mine', to: 'arenas#mine'
  get 'booking/mine', to: 'bookings#mine'
  get 'bookings/mine/:id', to: 'bookings#show', as: 'arena_booking'
  delete 'bookings/mine/:id', to: 'bookings#destroy'

  resources :arenas, only: [:index, :show, :new, :create, :destroy]
  # Defines the root path route ("/")
  # root "posts#index"
  # Routes pour les arènes avec les actions index et show
  resources :arenas do
    resources :bookings, only: [:index, :show, :new, :create]
  end
end
