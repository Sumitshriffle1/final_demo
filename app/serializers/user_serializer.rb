class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :password, :contact,:type
end
