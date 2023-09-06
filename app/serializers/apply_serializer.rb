class ApplySerializer < ActiveModel::Serializer
  attributes :id,:name,:job_title,:company_name,:job_category,:resume,:status

  def name
    object.user.name
  end

  def job_title
    object.job.job_title
  end

  def company_name
    object.job.company_name
  end

  def job_category
    object.job.job_category
  end
end
