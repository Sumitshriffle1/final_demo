ActiveAdmin.register User do
  permit_params :name, :email,:password_digest,:contact,:type

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :password_digest
    column :contact
    column :type
    actions
  end
  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :password_digest
      f.input :contact
      f.input :type
    end
    f.actions
  end
end
