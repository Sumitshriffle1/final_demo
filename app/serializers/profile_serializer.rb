class ProfileSerializer < ActiveModel::Serializer
  attributes :image, :skills, :education, :experience
end
