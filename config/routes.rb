Rails.application.routes.draw do
  devise_for :users
  root to: 'mentals#index'
  resources :mentals, only: [:index, :new, :create, :show] do
    collection do
      get 'result'
    end
    member do
      get 'user'
    end
  end
  resources :users, only: [:show ,:update]
end
