Rails.application.routes.draw do
	root 'static_page#home'
  devise_for :users
  resources :charges
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
