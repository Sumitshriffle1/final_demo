class JobSerializer < ActiveModel::Serializer
  attributes :id, :job_title,:company_name, :job_category, :job_description, :salary, :post, :location
end
