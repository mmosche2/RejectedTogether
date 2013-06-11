RejectionTherapy::Application.routes.draw do

  root :to => 'home#index'

  resources :users do
  	member do 
  		get :profile
  	end
  end
	match '/logout', :to => 'users#logout'


end
