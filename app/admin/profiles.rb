ActiveAdmin.register Profile do
  permit_params :skills, :education, :experience, :user_id,:image

  index do
    selectable_column
    id_column
    column :skills
    column :education
    column :experience
    column :user_id
    column :image do |img|
      image_tag url_for(img.image),size: 5*5
    end
    actions
  end
  filter :created_at
  filter :user_id

  show do
    attributes_table do
      row :id
      row :skills
      row :education
      row :experience
      row :image do |img|
        image_tag url_for(img.image)
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :skills
      f.input :education
      f.input :experience
      f.input :user
      f.input :image, as: :file
    end
    f.actions
  end
end
