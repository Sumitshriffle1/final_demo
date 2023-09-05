class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :password, :contact
end
