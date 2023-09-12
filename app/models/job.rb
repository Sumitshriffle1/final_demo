class Job < ApplicationRecord
  belongs_to :user
  has_many :applies,dependent: :destroy

  validates :job_title,:company_name,:job_category,:job_description,:location,:salary, :post,presence: true
  validates :job_title, uniqueness: { scope: :user_id}
  def self.ransackable_associations(auth_object = nil)
    ["applies", "user"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["company_name", "created_at", "id", "job_category", "job_description", "job_title", "location", "post", "salary", "updated_at", "user_id"]
  end
end
