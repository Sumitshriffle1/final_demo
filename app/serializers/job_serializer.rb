class JobSerializer < ActiveModel::Serializer
  attributes :id, :job_title, :job_category, :job_description, :salary, :post, :location
end
