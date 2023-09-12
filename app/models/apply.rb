class Apply < ApplicationRecord
  belongs_to :job
  belongs_to :user
  has_one_attached :resume

  validates :resume, presence: true
  validates :job_id, uniqueness: { scope: :user_id}

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "job_id", "status", "updated_at", "user_id"]
  end
end
