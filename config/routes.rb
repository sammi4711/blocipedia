Rails.application.routes.draw do
  devise_for :users

  resources :users, :only => [:index, :show]
  resources :charges, only: [:new, :create]
  resources :wikis 
  resources :wikis do
    resources :collaborators 
  end
  

  get 'collaborators/:id', to: 'collaborators#show'
  #delete 'collaborators/destroy'
  delete 'charges/downgrade'

  get 'about' => 'welcome#about'

  root 'welcome#index'
end