class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :skills, :education, :experience, presence: true
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "education", "experience", "id", "skills", "updated_at", "user_id"]
  end
end
