Rails.application.routes.draw do

  root 'home#index'

<<<<<<< HEAD
  resource :cart, only: [:show]

  resources :products do
=======
  resources :products, except: [:new, :edit] do
>>>>>>> 7ee8c1cc54815e1d7b2764944c92c41caab3b82a
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
end
