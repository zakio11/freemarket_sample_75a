Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }

  devise_scope :user do
    get 'profiles', to: 'users/registrations#new_profile'
    post 'profiles', to: 'users/registrations#create_profile'
  end
  
  root 'items#index'
  get "users/signout"
  
  resources :items, only: [:index, :new, :create, :show, :destroy, :edit, :update]
  resources :users, only: [:new, :create, :show, :destroy]
  resources :cards, only: [:new, :edit, :show, :destroy, :pay]
  
end
