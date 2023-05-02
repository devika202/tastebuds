Rails.application.routes.draw do
  get 'orders/index'
  get 'orders/show'
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
  get '/checkout', to: 'checkout#new'
  post '/checkout', to: 'checkout#create', as: 'create_order'
  post 'orders', to: 'orders#create', as: 'order'
  resources :carts, only: [:show, :create, :update, :destroy]
  post '/search', to: 'products#search', as: 'products_search'
  get '/orders/:id/confirmation', to: 'orders#order_confirmation', as: 'order_confirmation'

end
