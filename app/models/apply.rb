class Apply < ApplicationRecord
  belongs_to :job
  belongs_to :user

  validates :resume, presence: true
  validates :job_id, uniqueness: { scope: :user_id}
end
