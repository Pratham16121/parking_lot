Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :cars, only: [:create, :index]
  resources :tickets, only: [:create, :update]
  resources :slots, only: [:index]
end
