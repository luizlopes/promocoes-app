Rails.application.routes.draw do
  devise_for :users
  root 'promotions#index'
  resources :promotions, only: [:new, :create, :show, :index] do
    resources :coupons, only: [:create, :index, :destroy]
    post 'search', on: :collection
    get 'status', on: :collection
    get 'active', on: :member
    put 'approve', on: :member
  end
  resources :products, only: [:show, :new, :create]

  namespace :api do
    namespace :v1 do
      resources :coupons, only: [:show] do
        member do
          match 'burn', via: [:put, :patch]
        end
      end
    end
  end
end
