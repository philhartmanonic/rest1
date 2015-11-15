Rails.application.routes.draw do
  devise_for :owners
  root 'restaurants#index'

  resources :restaurants
end
