Rails.application.routes.draw do
  devise_for :users
  resources  :users, :only => [:index, :show]
  resources :sessions, only: [:new, :create, :destroy]

  get 'welcome/index'
  get 'welcome/about'

  root 'welcome#index'

  devise_scope :user do 
    root to: 'static_pages#home'
    match '/sessions/user', to: 'devise/sessions#create', via: :post
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
