Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Page d'accueil
  root to: 'pages#home'

  # Routes pour les arènes avec les actions index et show
  resources :arenas do
    resources :bookings, only: [:index, :show, :new, :create]
  end
end
