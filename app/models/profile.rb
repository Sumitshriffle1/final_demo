class Profile < ApplicationRecord
  belongs_to :user

  validates :skills, :education, :experience, presence: true
end
