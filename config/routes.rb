Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :items, only: %i[new create show edit update destroy]
end
