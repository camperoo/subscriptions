Subscriptions::Engine.routes.draw do
  resources :customers, only: [:index, :show]
  resources :plans, only: [:index, :show]
end
