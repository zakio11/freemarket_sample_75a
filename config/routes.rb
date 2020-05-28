Rails.application.routes.draw do
  get 'card/new'
  get 'card/show'
  devise_for :users
  root 'items#index'
  
  resources :items, only: [:index, :new, :create, :show, :destroy, :edit, :update]
  resources :users, only: [:show, :destroy, :logout]
  resources :card, only: [:new, :show] do
    collection do
      post 'show', to: 'card#show'
      post 'pay', to: 'card#pay'
      post 'delete', to: 'card#delete'
    end
  end
end
