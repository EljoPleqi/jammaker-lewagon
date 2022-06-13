Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/auth/spotify/callback', to: 'users#token'
  post '/auth/spotify', to: 'users#find_user'
  get '/login', to: 'users#login'
  # post '/auth/spotify', to: 'users#spotify'
  resources :recipes, only: [ :show, :index, :create, :destroy, :update ] do
    resources :instructions, only: [ :new, :create ]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
