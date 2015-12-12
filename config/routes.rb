Rails.application.routes.draw do

  root 'home#index'

  get "/cart" => "orders#cart", as: "cart"

  resources :products, except: [:new, :edit] do
    resources :reviews, except: [:index]
  end

  resources :merchants do
    resources :products, only: [:index, :new, :edit]
  end

  resources :categories do
    resources :products, only: [:index]
  end

  resources :order do
    resources :orderitem do
    end
  end

  resources :order_items do
  end

  resources :sessions, :only => [:new, :create]

  delete "/logout", to: "sessions#destroy", as: :logout

end
