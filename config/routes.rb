Rails.application.routes.draw do
  root 'boards#index'

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  get 'user/new', to: 'users#new'
  post 'user/new', to: 'users#create'

  get 'user', to: 'users#show'

  # get 'user/password', to: 'users#edit_password'
  # patch 'user/password', to: 'users#update_password'
  resources :password_resets, only: %i[new create edit update]
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  get 'user/name', to: 'users#edit_name'
  patch 'user/name', to: 'users#update_name'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
