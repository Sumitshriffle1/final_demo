ActiveAdmin.register Job do
  permit_params :job_title, :company_name, :job_category, :job_description, :salary, :location, :post, :user_id
  
  index do
    selectable_column
    id_column
    column :job_title
    column :company_name
    column :job_category
    column :job_description
    column :salary
    column :post
    column :user_id
    column :location
    actions
  end
  filter :job_title
  filter :job_category
  filter :job_description
  filter :company_name
  filter :salary
  filter :location
  filter :user_id
end
