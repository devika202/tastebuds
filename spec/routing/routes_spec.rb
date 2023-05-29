require 'rails_helper'

RSpec.describe 'Routes', type: :routing do
  describe 'GET /order_history/index' do
    it 'routes to order_history#index' do
      expect(get: '/order_history/index').to route_to('order_history#index')
    end
  end

  describe 'GET /users/index' do
    it 'routes to users#index' do
      expect(get: '/users/index').to route_to('users#index')
    end
  end

  describe 'Devise routes' do
    it 'routes to devise_for :users' do
      expect(get: '/users/sign_in').to route_to('devise/sessions#new')
      expect(post: '/users/sign_in').to route_to('devise/sessions#create')
      expect(delete: '/users/sign_out').to route_to('devise/sessions#destroy')
      expect(get: '/users/password/new').to route_to('devise/passwords#new')
      expect(get: '/users/password/edit').to route_to('devise/passwords#edit')
      expect(patch: '/users/password').to route_to('devise/passwords#update')
      expect(put: '/users/password').to route_to('devise/passwords#update')
      expect(post: '/users/password').to route_to('devise/passwords#create')
      expect(get: '/users/cancel').to route_to('devise/registrations#cancel')
      expect(get: '/users/sign_up').to route_to('devise/registrations#new')
      expect(get: '/users/edit').to route_to('devise/registrations#edit')
      expect(patch: '/users').to route_to('devise/registrations#update')
      expect(put: '/users').to route_to('devise/registrations#update')
      expect(delete: '/users').to route_to('devise/registrations#destroy')
      expect(post: '/users').to route_to('devise/registrations#create')
    end
  end

  describe 'GET /users' do
    it 'routes to users#index' do
      expect(get: '/users').to route_to('users#index')
    end
  end

  describe 'GET /users/:id' do
    it 'routes to users#show' do
      expect(get: '/users/1').to route_to('users#show', id: '1')
    end
  end

  describe 'GET root' do
    it 'routes to pages#home' do
      expect(get: '/').to route_to('pages#home')
    end
  end

  describe 'GET /about' do
    it 'routes to pages#about' do
      expect(get: '/about').to route_to('pages#about')
    end
  end

  describe 'resources :products' do
    it 'routes to products#index' do
      expect(get: '/products').to route_to('products#index')
    end

    it 'routes to products#show' do
      expect(get: '/products/1').to route_to('products#show', id: '1')
    end

    it 'routes to products#create' do
      expect(post: '/products').to route_to('products#create')
    end

    it 'routes to products#update' do
      expect(put: '/products/1').to route_to('products#update', id: '1')
    end

    it 'routes to products#destroy' do
      expect(delete: '/products/1').to route_to('products#destroy', id: '1')
    end
  end

  describe 'PUT /remove_item/:id' do
    it 'routes to carts#remove_item' do
      expect(put: '/remove_item/1').to route_to('carts#remove_item', id: '1')
    end
  end

  describe 'DELETE /clear_cart' do
    it 'routes to carts#clear_cart' do
      expect(delete: '/clear_cart').to route_to('carts#clear_cart')
    end
  end

  describe 'GET /orders/new' do
    it 'routes to orders#new' do
      expect(get: '/orders/new').to route_to('orders#new')
    end
  end

  describe 'resources :categories' do
    it 'routes to categories#index' do
      expect(get: '/categories').to route_to('categories#index')
    end

    it 'routes to categories#new' do
      expect(get: '/categories/new').to route_to('categories#new')
    end

    it 'routes to categories#create' do
      expect(post: '/categories').to route_to('categories#create')
    end

    it 'routes to categories#show' do
      expect(get: '/categories/1').to route_to('categories#show', id: '1')
    end

    it 'routes to categories#edit' do
      expect(get: '/categories/1/edit').to route_to('categories#edit', id: '1')
    end

    it 'routes to categories#update' do
      expect(put: '/categories/1').to route_to('categories#update', id: '1')
    end

    it 'routes to categories#destroy' do
      expect(delete: '/categories/1').to route_to('categories#destroy', id: '1')
    end
  end

  describe 'GET /checkout' do
    it 'routes to checkout#new' do
      expect(get: '/checkout').to route_to('checkout#new')
    end
  end

  describe 'POST /checkout' do
    it 'routes to checkout#create' do
      expect(post: '/checkout').to route_to('checkout#create')
    end
  end

  describe 'resources :orders' do
    it 'routes to orders#show' do
      expect(get: '/orders/1').to route_to('orders#show', id: '1')
    end

    it 'routes to orders#create' do
      expect(post: '/orders').to route_to('orders#create')
    end
  end

  describe 'resources :carts' do
    it 'routes to carts#show' do
      expect(get: '/carts/1').to route_to('carts#show', id: '1')
    end

    it 'routes to carts#create' do
      expect(post: '/carts').to route_to('carts#create')
    end

    it 'routes to carts#update' do
      expect(put: '/carts/1').to route_to('carts#update', id: '1')
    end

    it 'routes to carts#destroy' do
      expect(delete: '/carts/1').to route_to('carts#destroy', id: '1')
    end
  end

  
  describe 'POST /search' do
    it 'routes to shop_sales_reports#search' do
      expect(post: '/search').to route_to('shop_sales_reports#search')
    end
  end

  describe 'resources :users' do
    it 'routes to users#index' do
      expect(get: '/users').to route_to('users#index')
    end

    it 'routes to users#show' do
      expect(get: '/users/1').to route_to('users#show', id: '1')
    end

    it 'does not route to users#destroy' do
      expect(delete: '/users/1').to route_to('users#destroy', id: '1')
    end
  end

  describe 'GET /orders/:id/confirmation' do
    it 'routes to orders#order_confirmation' do
      expect(get: '/orders/1/confirmation').to route_to('orders#order_confirmation', id: '1')
    end
  end

  describe 'GET /order_history' do
    it 'routes to order_history#index' do
      expect(get: '/order_history').to route_to('order_history#index')
    end
  end

  describe 'GET /shops/login' do
    it 'routes to shops#login' do
      expect(get: '/shops/login').to route_to('shops#login')
    end
  end

  describe 'POST /shops/login' do
    it 'routes to shops#login' do
      expect(post: '/shops/login').to route_to('shops#login')
    end
  end

  describe 'DELETE /shops/logout' do
    it 'routes to shops#logout' do
      expect(delete: '/shops/logout').to route_to('shops#logout')
    end
  end

  describe 'GET /shops/dashboard' do
    it 'routes to shops#dashboard' do
      expect(get: '/shops/dashboard').to route_to('shops#dashboard')
    end
  end

  describe 'GET /admin/new_shop' do
    it 'routes to admin#new_shop' do
      expect(get: '/admin/new_shop').to route_to('admin#new_shop')
    end
  end

  describe 'POST /admin/create_shop' do
    it 'routes to admin#create_shop' do
      expect(post: '/admin/create_shop').to route_to('admin#create_shop')
    end
  end

  describe 'resources :shop_sales_reports' do
    it 'routes to shop_sales_reports#index' do
      expect(get: '/shop_sales_reports').to route_to('shop_sales_reports#index')
    end

    it 'routes to shop_sales_reports#new' do
      expect(get: '/shop_sales_reports/new').to route_to('shop_sales_reports#new')
    end

    it 'routes to shop_sales_reports#create' do
      expect(post: '/shop_sales_reports').to route_to('shop_sales_reports#create')
    end

    it 'routes to shop_sales_reports#edit' do
      expect(get: '/shop_sales_reports/1/edit').to route_to('shop_sales_reports#edit', id: '1')
    end

    it 'routes to shop_sales_reports#update' do
      expect(put: '/shop_sales_reports/1').to route_to('shop_sales_reports#update', id: '1')
    end

    it 'routes to shop_sales_reports#destroy' do
      expect(delete: '/shop_sales_reports/1').to route_to('shop_sales_reports#destroy', id: '1')
    end
  end

  describe 'resources :shops' do
    it 'routes to shops#index' do
      expect(get: '/shops').to route_to('shops#index')
    end

    it 'routes to shops#new' do
      expect(get: '/shops/new').to route_to('shops#new')
    end

    it 'routes to shops#create' do
      expect(post: '/shops').to route_to('shops#create')
    end

    it 'routes to shops#edit' do
      expect(get: '/shops/1/edit').to route_to('shops#edit', id: '1')
    end

    it 'routes to shops#update' do
      expect(put: '/shops/1').to route_to('shops#update', id: '1')
    end

    it 'routes to shops#show' do
      expect(get: '/shops/1').to route_to('shops#show', id: '1')
    end

    it 'routes to shops#destroy' do
      expect(delete: '/shops/1').to route_to('shops#destroy', id: '1')
    end
  end

  describe 'admin namespace' do
    describe 'resources :orders' do
      it 'routes to admin/orders#index' do
        expect(get: '/admin/orders').to route_to('admin/orders#index')
      end

      it 'routes to admin/orders#show' do
        expect(get: '/admin/orders/1').to route_to('admin/orders#show', id: '1')
      end

      it 'routes to admin/orders#edit' do
        expect(get: '/admin/orders/1/edit').to route_to('admin/orders#edit', id: '1')
      end

      it 'routes to admin/orders#update' do
        expect(put: '/admin/orders/1').to route_to('admin/orders#update', id: '1')
      end
    end

    describe 'resources :shops' do
      it 'routes to admin/shops#new' do
        expect(get: '/admin/shops/new').to route_to('admin/shops#new')
      end

      it 'routes to admin/shops#create' do
        expect(post: '/admin/shops').to route_to('admin/shops#create')
      end

      it 'routes to admin/shops#edit' do
        expect(get: '/admin/shops/1/edit').to route_to('admin/shops#edit', id: '1')
      end

      it 'routes to admin/shops#update' do
        expect(put: '/admin/shops/1').to route_to('admin/shops#update', id: '1')
      end

      it 'routes to admin/shops#index' do
        expect(get: '/admin/shops').to route_to('admin/shops#index')
      end

      it 'routes to admin/shops#destroy' do
        expect(delete: '/admin/shops/1').to route_to('admin/shops#destroy', id: '1')
      end
    end

    describe 'admin namespace GET /admin/sales_reports' do
    it 'routes to admin/shop_sales_reports#admin_index' do
        expect(get: '/admin/sales_reports').to route_to('shop_sales_reports#admin_index')
    end
  end
  end

  describe 'resources :products do resources :reviews' do
    it 'routes to reviews#index' do
      expect(get: '/products/1/reviews').to route_to('reviews#index', product_id: '1')
    end

    it 'routes to reviews#new' do
      expect(get: '/products/1/reviews/new').to route_to('reviews#new', product_id: '1')
    end

    it 'routes to reviews#create' do
      expect(post: '/products/1/reviews').to route_to('reviews#create', product_id: '1')
    end

    it 'routes to reviews#edit' do
      expect(get: '/products/1/reviews/1/edit').to route_to('reviews#edit', product_id: '1', id: '1')
    end

    it 'routes to reviews#update' do
      expect(put: '/products/1/reviews/1').to route_to('reviews#update', product_id: '1', id: '1')
    end

    it 'routes to reviews#destroy' do
      expect(delete: '/products/1/reviews/1').to route_to('reviews#destroy', product_id: '1', id: '1')
    end
  end

  describe 'admin namespace' do
    describe 'resources :accounting' do
      it 'routes to admin/accounting#index' do
        expect(get: '/admin/accounting').to route_to('admin/accounting#index')
      end

      it 'routes to admin/accounting#new' do
        expect(get: '/admin/accounting/new').to route_to('admin/accounting#new')
      end

      it 'routes to admin/accounting#create' do
        expect(post: '/admin/accounting').to route_to('admin/accounting#create')
      end

      it 'routes to admin/accounting#edit' do
        expect(get: '/admin/accounting/1/edit').to route_to('admin/accounting#edit', id: '1')
      end

      it 'routes to admin/accounting#update' do
        expect(put: '/admin/accounting/1').to route_to('admin/accounting#update', id: '1')
      end

      it 'routes to admin/accounting#destroy' do
        expect(delete: '/admin/accounting/1').to route_to('admin/accounting#destroy', id: '1')
      end
    end

    describe 'GET /admin/accounting/search' do
      it 'routes to admin/accounting#search' do
        expect(get: '/admin/accounting/search').to route_to('admin/accounting#search')
      end
    end
  end
end
