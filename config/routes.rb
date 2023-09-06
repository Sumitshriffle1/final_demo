Rails.application.routes.draw do
  post "user_login", to: "users#user_login"
  get 'search_user_by_name',to:'jobs#search_user_by_name'
  resource :users

  put 'reject_apply',to: 'job_recruiters#reject_apply'
  get 'find_by_id/:id',to: 'job_recruiters#find_by_id'
  get 'view_rejected_apply',to: 'job_recruiters#view_rejected_apply'
  get 'view_accepted_apply',to: 'job_recruiters#view_accepted_apply'
  resources :job_recruiters,only: [:index]

  get 'search_by_name',to:'jobs#search_by_name'
  get 'search_by_company_name',to:'jobs#search_by_company_name'
  get 'search_by_category',to:'jobs#search_by_category'
  resources :jobs

  resource :applies
end
