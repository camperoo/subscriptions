Rails.application.routes.draw do

  mount Subscriptions::Engine => "/subscriptions"
end
