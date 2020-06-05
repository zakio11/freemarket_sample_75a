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
  get "items/edit"
  get "cards/menu"
  get 'buyers/done'


  resources :items do
    collection do
      get 'category_children', defaults: { format: 'json'}
      get 'category_grandchildren', defaults: { format: 'json'}
    end
    resources :image
    resources :buyers, only: [:index]

  end

  resources :users, only: [:new, :create, :show, :destroy]

  resources :cards, only: [:new, :show]do
    collection do
      post 'show', to: 'cards#show'
      post 'pay', to: 'cards#pay'
      post 'delete', to: 'cards#delete'
    end
  end
  
end
