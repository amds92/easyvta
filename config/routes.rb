Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token

  root "home#index"

  # Public orders
  resources :orders, only: [:new, :create] do
    collection do
      get :confirmation, path: "confirmation/:reference"
    end
  end
  get "order/:product_slug", to: "orders#new", as: :order_product

  namespace :admin do
    root "dashboard#index"
    resources :products do
      member do
        patch :toggle_stock
      end
      collection do
        patch :reorder
      end
    end
    resources :orders, only: [:index, :show] do
      member do
        patch :update_status
      end
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
