class ApplySerializer < ActiveModel::Serializer
  attributes :id,:status,:user_id,:job_title,:job_category,:company_name,:resume

  def resume
    object.resume.url
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
