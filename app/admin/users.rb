ActiveAdmin.register User do
  permit_params :name, :email,:type

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :type
    actions
  end
  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :type
    end
    f.actions
  end
end
