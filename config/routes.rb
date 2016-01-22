Rails.application.routes.draw do

  root 'home#index'

  get "/cart" => "orders#cart", as: "cart"
  get "/checkout" => "orders#checkout", as: "checkout"
  post "/confirmation" => "orders#confirmation", as: "confirmation"
  get "/shipping_estimate" => "orders#shipping_estimate", as: "shipping_estimate"
  post "/confirm" => "orders#confirm_order", as: "confirm"

  resources :products do
    resources :reviews, except: [:index]
    get :retire, on: :member
  end

  resources :merchants do
    resources :products, only: [:index]
  end

  resources :categories, only: [:new, :create] do
    resources :products, only: [:index]
  end

  resources :orders do
  end

  resources :order_items do
    put :shipped, on: :member
  end

  resources :sessions, :only => [:new, :create]

  delete "/logout", to: "sessions#destroy", as: :logout

end
