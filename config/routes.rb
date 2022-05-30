Rails.application.routes.draw do
  get '/auth/spotify/callback', to: 'users#spotify'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }


  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :dashboard, only: [:show] do
    resources :recipies, only: [ :index, :create, :destroy ]
  end

  resources :recipies, only: [:show]
end
