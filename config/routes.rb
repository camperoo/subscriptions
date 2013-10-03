Subscriptions::Engine.routes.draw do
  resources :customers, only: [:index, :show]
  resources :plans
  root 'home#index'
end
