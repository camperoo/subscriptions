Subscriptions::Engine.routes.draw do

  resources :credit_cards

  resources :payments
  resources :invoices
  resources :line_items
  resources :subscriptions
  resources :plans
  resources :groups

end
