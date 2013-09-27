Subscriptions::Engine.routes.draw do

  resources :customers, only: [:index]

end
