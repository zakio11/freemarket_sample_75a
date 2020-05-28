Rails.application.routes.draw do
  get 'card/new'
  get 'card/show'
  devise_for :users
  root 'items#index'
  
  resources :items, only: [:index, :new, :create, :show, :destroy, :edit, :update]
  resources :users, only: [:show, :destroy, :logout]
  
end
