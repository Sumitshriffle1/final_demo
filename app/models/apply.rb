class Apply < ApplicationRecord
  belongs_to :job
  belongs_to :user

  validates :resume, presence: true

end
