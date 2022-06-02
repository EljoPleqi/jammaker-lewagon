Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/auth/spotify/callback', to: 'users#spotify'
  post '/auth/spotify/callback', to: 'users#spotify'
  resources :recipes, only: [ :show, :index, :create, :destroy ] do
    resources :instructions, only: [ :new, :create ]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
