class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :skills, :education, :experience, presence: true
end
