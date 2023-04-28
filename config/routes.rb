Rails.application.routes.draw do
  get 'users/index'
  devise_for :users
  get '/users', to: 'users#index'
  get '/users/:id', to: 'users#show', as: 'user'
  root 'pages#home'
  resources :products
  put 'remove_item/:id', to: 'carts#remove_item', as: :remove_item
  delete '/clear_cart', to: 'carts#clear_cart', as: 'clear_cart'
  get '/orders/new', to: 'orders#new', as: 'new_order'
  resources :categories, except: [:destroy]
  resources :categories, param: :id
  resources :products, only: [:index]
  resources :carts, only: [:show, :create, :update, :destroy]
  post '/search', to: 'products#search', as: 'products_search'
end
