Rails.application.routes.draw do
  get '/auth/spotify/callback', to: 'users#spotify'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    delete 'sign_out', :to => 'devise/sessions#destroy'
  end

  root to: 'pages#home'
  get "/scraper", to: "pages#scraper"
  post "/query", to: 'pages#fetch'
  get "/query", to: 'pages#query'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :dashboard, only: [:show]
  resources :recipes, only: [ :show, :index, :create, :destroy ] do
    resources :instructions, only: [ :new, :create ]
  end

end
