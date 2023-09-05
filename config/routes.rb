Rails.application.routes.draw do
  post "user_login", to: "users#user_login"
  resources :users
  resource :profiles
  resources :jobs
end
