Rails.application.routes.draw do
  post "user_login", to: "users#user_login"
  resource :users do
    get 'search_user_by_name',to:'users#search_user_by_name'
    resource :profiles
    resources :applies
    resources :jobs do
      get 'search_by_job_title',to:'jobs#search_by_job_title'
      get 'search_by_company_name',to:'jobs#search_by_company_name'
      get 'search_by_category',to:'jobs#search_by_category'
    end
  end

  get 'view_applied_jobs', to: 'job_recruiters#view_applied_jobs'
  get 'view_rejected_apply', to: 'job_recruiters#view_rejected_apply'
  get 'view_accepted_apply',to: 'job_recruiters#view_accepted_apply'
  resources :job_recruiters

  match "*path", to: "application#invalid_url", via: :all
end
