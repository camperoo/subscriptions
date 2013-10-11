Subscriptions::Engine.routes.draw do
  resources :credit_cards, only: [:new, :index]
  resources :customers, only: [:index, :show]
  resources :plans
  root 'home#index'
end
