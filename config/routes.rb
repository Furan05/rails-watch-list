Rails.application.routes.draw do
  # Root route
  root 'lists#index'

  # Route pour la recherche de films
  get 'movies/search', to: 'movies#search'

  # Routes pour les listes et les bookmarks
  resources :lists, only: [:index, :show, :new, :create, :destroy] do
    resources :bookmarks, only: [:new, :create]
  end

  # Route standalone pour la suppression des bookmarks
  resources :bookmarks, only: :destroy

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
