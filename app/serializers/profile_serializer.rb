class ProfileSerializer < ActiveModel::Serializer
  attributes :skills, :education, :experience, :image
  def image
    object.image.url
  end
end
