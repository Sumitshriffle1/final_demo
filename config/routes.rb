Rails.application.routes.draw do
  post "user_login", to: "users#user_login"
  resources :users
  resource :profiles
  get 'search_by_name',to:'jobs#search_by_name'
  get 'search_by_company_name',to:'jobs#search_by_company_name'
  get 'search_by_category',to:'jobs#search_by_category'
  resources :jobs
  
end
