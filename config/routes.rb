Rails.application.routes.draw do
  devise_for :users
  root to: 'mentals#index'
  resources :mentals
end
