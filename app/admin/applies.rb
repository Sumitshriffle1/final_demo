ActiveAdmin.register Apply do
  permit_params :status, :job_id, :user_id,:resume
  
  index do
    selectable_column
    id_column
    column :status
    column :job_id
    column :user_id
    column :resume do |apply|
      link_to "Download Resume", apply.resume.url
    end
    actions
  end
  filter :created_at
  filter :status

  form do |f|
    f.inputs do
      f.input :status
      f.input :job_id
      f.input :user_id
      f.input :resume, as: :file
    end
    f.actions
  end
end
