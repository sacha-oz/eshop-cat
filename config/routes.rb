Rails.application.routes.draw do
	root 'items#index'
  devise_for :users

  resources :charges
  resources :carts, only:[:create, :show, :destroy]
  resources :items, only: [:show, :index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
