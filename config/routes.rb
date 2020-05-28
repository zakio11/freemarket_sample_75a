Rails.application.routes.draw do
  
  devise_for :users
  root 'items#index'
  
  resources :items, only: [:index, :new, :create, :show, :destroy, :edit, :update]
  resources :users, only: [:show, :destroy, :logout]
  
end
