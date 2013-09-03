Subscriptions::Engine.routes.draw do
  resources :customers

  resources :subscriptions

  resources :plans

  resources :groups

end
