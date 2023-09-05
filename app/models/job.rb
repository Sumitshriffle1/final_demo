class Job < ApplicationRecord
  belongs_to :user
  has_many :applies

  validates :job_title,:company_name,:job_category,:job_description,:location,:salary, :post,presence: true
  validates :job_title, uniqueness: { scope: :user_id}
end
