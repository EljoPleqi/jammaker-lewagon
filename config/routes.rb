Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get "/scraper", to: "pages#scraper"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
