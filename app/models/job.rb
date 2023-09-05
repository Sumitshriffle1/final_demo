class Job < ApplicationRecord
  belongs_to :user
  has_many :applies,dependent: :destroy

  validates :job_title,:company_name,:job_category,:job_description,:location,:salary, :post,presence: true
  validates :job_title, uniqueness: { scope: :user_id}
  validate :only_recruiter_has_access

  private
  def only_recruiter_has_access
    unless user.type == "JobRecruiter"
      errors.add(:base, "Only Recruiter has acess....")      
    end
  end
end
