class Apply < ApplicationRecord
  belongs_to :job
  belongs_to :user
  has_one_attached :resume

  validates :resume, presence: true
  validates :job_id, uniqueness: { scope: :user_id}
end
