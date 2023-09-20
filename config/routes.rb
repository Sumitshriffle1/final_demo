Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  post "user_login", to: "users#user_login"
  resource :users do
    resource :profiles
    resources :applies
    collection do
      get 'search_user_by_name'
      post 'forgot_password'
      post 'reset_password'
    end
  end

  resources :jobs do
    collection do
      get 'search_by_job_title'
      get 'search_by_company_name'
      get 'search_by_category'
    end
  end

  resources :job_recruiters do
    collection do
      get 'view_applied_jobs'
      get 'view_rejected_apply'
      get 'view_accepted_apply'
    end
  end
end
