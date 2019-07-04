Rails.application.routes.draw do
  #get 'wikis/index'
  #get 'wikis/show'
  #get 'wikis/new'
  #get 'wikis/edit'
  resources :wikis 

  devise_for :users
  resources  :users, :only => [:index, :show]
  resources :charges, only: [:new, :create]
  
  delete 'charges/downgrade'

  #get 'welcome/index'
  #get 'welcome/about'
  get 'about' => 'welcome#about'

  root 'welcome#index'
end