Rails.application.routes.draw do

  devise_for :users
  mount Subscriptions::Engine => "/subscriptions"
end
