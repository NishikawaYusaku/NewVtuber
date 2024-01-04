Rails.application.routes.draw do
  root 'boards#index'

  get 'user/new', to: 'users#new'
  get 'user', to: 'users#show'
  get 'user/name', to: 'users#edit_name'
  patch 'user/name', to: 'users#update_name'

  # get 'users', to: "users#new"
=begin
  get 'users', to: "users#new"

  resource :users
  resource :user


  get 'user/name', to: 'users#edit_name'
  patch 'user/name', to: 'users#update_name'
=end

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
