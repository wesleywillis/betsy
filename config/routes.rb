Rails.application.routes.draw do

  root 'home#index'
  
  resources :products do
    resources :reviews, except: [:index]
  end

  resources :merchants do
    resources :products, only: [:show]
  end

  resources :categories do
    resources :products, only: [:show]
  end

  resources :order do
    resources :orderitem do
    end
  end
end
