Rails.application.routes.draw do
  post "user_login", to: "users#user_login"
  resources :users
  get 'search_by_name',to:'jobs#search_by_name'
  get 'search_by_company_name',to:'jobs#search_by_company_name'
  get 'search_by_category',to:'jobs#search_by_category'
  resources :jobs
  put 'reject_apply',to: 'applies#reject_apply'
  get 'find_by_id/:id',to: 'applies#find_by_id'
  get 'view_rejected_apply',to: 'applies#view_rejected_apply'
  get 'view_accepted_apply',to: 'applies#view_accepted_apply'
  resource :applies
end
