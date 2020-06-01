Rails.application.routes.draw do
  devise_for :users
  root 'items#index'

  resources :items do
    collection do 
      get 'category_children', defaults: { format: 'json'}
      get 'category_grandchildren', defaults: { format: 'json'}
    end
    resources :image
  end

  resources :users


end
