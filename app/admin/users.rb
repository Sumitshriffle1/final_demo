ActiveAdmin.register User do
  permit_params :name, :email, :password_digest, :type,:skills, :education, :experience, :image


  index do
    selectable_column
    id_column
    column :name
    column :email
    column :password_digest
    column :type
    actions
  end
  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :password
    end
    f.actions
  end


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :email, :password_digest, :contact, :type
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :email, :password_digest, :contact, :type]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
