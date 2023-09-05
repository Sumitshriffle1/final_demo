class Profile < ApplicationRecord
  belongs_to :user

  validates :skills, :dob, :experience, presence: true
end
