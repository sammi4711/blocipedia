Rails.application.routes.draw do
  devise_for :users

  resources :users, :only => [:index, :show]
  resources :charges, only: [:new, :create]
  resources :collaborators 
  resources :wikis 
  
  resources :collaborators, only: [:create, :destroy]

  
  delete 'charges/downgrade'

  get 'about' => 'welcome#about'

  root 'welcome#index'
end