Subscriptions::Engine.routes.draw do
  resources :payments

  resources :invoices

  resources :line_items

  resources :customers

  resources :subscriptions

  resources :plans

  resources :groups

end
