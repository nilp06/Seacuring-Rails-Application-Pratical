Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, only: %i[new create]
  resources :sessions, only: %i[new create]
  get 'sessions/destroy', to: 'sessions#destroy', as: 'destroy'
  get 'home/index', to: 'home#index'
  root 'home#index'
end
