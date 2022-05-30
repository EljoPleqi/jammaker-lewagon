Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get "/scraper", to: "pages#scraper"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :dashboard, only: [:show]
  resources :recipes, only: [ :index, :create,:destroy ] do
    resources :instructions, only: [ :new, :create ]
  end

  resources :recipes, only: [:show]
end
